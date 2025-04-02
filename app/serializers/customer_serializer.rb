class CustomerSerializer
  include FastJsonapi::ObjectSerializer

  attributes :first_name, :last_name, :email, :phone, :active

  has_many :orders  
end
