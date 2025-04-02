# app/serializers/item_price_history_serializer.rb
class ItemPriceHistorySerializer
  include FastJsonapi::ObjectSerializer

  set_type :price_history

  attributes :item, :prices

  attribute :item do |item|
    item.name
  end

  attribute :prices do |item|
    item.item_prices.order(:start_date).map do |price|
      {
        start_date: price.start_date.strftime('%Y-%m-%d'),
        end_date: price.end_date&.strftime('%Y-%m-%d'),
        price: ActionController::Base.helpers.number_to_currency(price.price)
      }
    end
  end
end
