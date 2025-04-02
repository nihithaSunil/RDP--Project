class OrderSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :date, :grand_total, :payment_receipt

  belongs_to :customer
  has_many :order_items
end
