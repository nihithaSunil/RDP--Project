class ItemSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name,
             :description,
             :category,
             :units_per_item,
             :weight

  attribute :current_price do |item|
    latest_price = item.item_prices.order(end_date: :desc).first
    latest_price ? "$#{'%.2f' % latest_price.price}" : "N/A"
  end

  attribute :orders_past_7_days do |item|
    recent_orders = OrderItem
                      .includes(order: :customer)
                      .where(item_id: item.id)
                      .where("orders.date >= ?", 7.days.ago)
                      .references(:orders)

    recent_orders.map do |order_item|
      {
        date: order_item.order.date.strftime("%Y-%m-%d"),
        customer: "#{order_item.order.customer.last_name}, #{order_item.order.customer.first_name}",
        quantity: order_item.quantity
      }
    end
  end
end
