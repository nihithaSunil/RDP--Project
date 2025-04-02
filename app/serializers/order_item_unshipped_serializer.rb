# app/serializers/order_item_unshipped_serializer.rb
class OrderItemUnshippedSerializer
  include FastJsonapi::ObjectSerializer

  set_type :order_item

  attributes :order_id, :order_date, :item, :quantity

  attribute :order_date do |order_item|
    order_item.order.date.strftime('%Y-%m-%d')
  end

  attribute :item do |order_item|
    order_item.item.name
  end
end
