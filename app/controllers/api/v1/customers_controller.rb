module Api::V1
  class CustomersController < ApiController


    def index
      customers = Customer.all
    
      customers = customers.active if params[:active] == "true"
      customers = customers.alphabetical if params[:alphabetical] == "true"
    
      result = customers.map do |customer|
        {
          id: customer.id.to_s,
          type: "customer",
          attributes: {
            last_name: customer.last_name,
            first_name: customer.first_name,
            email: customer.email,
            phone: format_phone(customer.phone),
            orders: customer.orders.map do |order|
              {
                data: {
                  id: order.id.to_s,
                  type: "order",
                  attributes: {
                    date: order.date.strftime('%Y-%m-%d'),
                    number_of_items: order.order_items.sum(:quantity),
                    grand_total: "$#{'%.2f' % order.grand_total}",
                    address: {
                      data: {
                        id: order.address.id.to_s,
                        type: "address",
                        attributes: {
                          recipient: order.address.recipient,
                          street_1: order.address.street_1,
                          street_2: order.address.street_2,
                          city: order.address.city,
                          state: order.address.state,
                          zip: order.address.zip
                        }
                      }
                    }
                  }
                }
              }
            end
          }
        }
      end
    
      render json: { data: result }
    end    





    private

    def format_phone(phone)
      phone.gsub(/(\d{3})(\d{3})(\d{4})/, '\1-\2-\3')
    end

  end
end