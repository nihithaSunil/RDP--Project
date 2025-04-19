class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  authorize_resource

  def index
    @all_orders = Order.chronological.all
  end

  def show
    @order_items = @order.order_items
    @other_orders = @order.customer.orders.where.not(id: @order.id).chronological.to_a
  end

  def new
    @order = Order.new
  end

  def create
    # if session[:cart].blank?
    #   flash[:error] = "You must add items to your cart before checking out."
    #   redirect_to items_path
    #   return
    # end
  
    @order = Order.new(order_params)
  
    # Assign virtual payment attributes (they must be assigned before validation)
  
    if @order.save
      # add_items_from_cart_to_order
      session[:cart] =[]
      flash[:notice] = "Thank you for ordering from Roi du Pain."
      redirect_to order_path(Order.last)
    else
      # This ensures the template renders if validation or payment fails
      render action: 'new'
    end
  end
  def edit; end

  def update
    # Set payment virtual attributes
    @order.credit_card_number = params[:order][:credit_card_number]
    @order.expiration_month = params[:order][:expiration_month]
    @order.expiration_year = params[:order][:expiration_year]

    if @order.update(order_params) && @order.pay
      flash[:notice] = "Order was revised in the system."
      redirect_to order_path(@order)
    else
      render :edit
    end
  end

  def destroy
    if @order.destroy
      flash[:notice] = "Order was removed from the system."
      redirect_to orders_path
    else
      flash[:error] = "Order cannot be removed from the system because some items have shipped."
      redirect_to order_path(@order)
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:customer_id, :address_id, :grand_total)
  end

  def add_items_from_cart_to_order
    session[:cart].each do |item_id, quantity|
      @order.order_items.build(item_id: item_id.to_i, quantity: quantity)
    end
    @order.grand_total = @order.order_items.sum { |oi| oi.subtotal || 0 }
  end
end
