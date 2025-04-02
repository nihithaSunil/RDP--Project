# app/controllers/api/v1/items_controller.rb
class Api::V1::ItemsController < ApiController
  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.new(item).serialized_json
  end

  def prices
    item = Item.find(params[:id])
    render json: ItemPriceHistorySerializer.new(item).serialized_json
  end
  
end
