# app/serializers/item_price_serializer.rb
class ItemPriceSerializer
  include FastJsonapi::ObjectSerializer

  attributes :price, :start_date, :end_date
end
