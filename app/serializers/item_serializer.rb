class ItemSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name,
             :description,
             :category,
             :units_per_item,
             :weight

  attribute :current_price do |item|
    price = item.current_price
    price.present? ? ActionController::Base.helpers.number_to_currency(price) : "N/A"
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
