# app/controllers/api/v1/orders_controller.rb
class Api::V1::OrdersController < ApiController
  def baking_list
    baking_list = OrderItem
      .joins(:item)
      .where(shipped_on: nil)
      .group('items.name')
      .sum(:quantity)
  
    render json: baking_list
  end
  

  def unshipped
    unshipped_items = OrderItem.unshipped.alphabetical
      # .includes(:order, :item)
      # .where(shipped_on: nil)
  
    render json: OrderItemUnshippedSerializer.new(unshipped_items).serialized_json
  end
  
end
