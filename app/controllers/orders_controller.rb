class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @all_orders = Order.chronological
  end

  def show
    @order_items = @order.order_items
    @other_orders = @order.customer.orders.where.not(id: @order.id).chronological
  end

  def new
    @order = Order.new
  end

  def create
    if session[:cart].blank?
      flash[:error] = "You must add items to your cart before checking out."
      redirect_to items_path
      return
    end

    @order = Order.new(order_params)
    @order.date = Date.current  # ensure date is always today, ignore params[:date]

    # Use OrderPayment module to set grand_total and payment_receipt
    @order.build_payment(params[:order][:credit_card_number], params[:order][:expiration_month], params[:order][:expiration_year])

    if @order.save
      add_items_from_cart_to_order
      session[:cart].clear
      flash[:notice] = "Thank you for ordering from Roi du Pain."
      redirect_to order_path(@order)
    else
      render :new
    end
  end

  def edit
  end

  def update
    # We ignore updates to :date and set it to current again if needed
    @order.date = Date.current

    @order.build_payment(params[:order][:credit_card_number], params[:order][:expiration_month], params[:order][:expiration_year])

    if @order.update(order_params)
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
    # `date` intentionally excluded
    params.require(:order).permit(:customer_id, :address_id, :grand_total)
  end

  def add_items_from_cart_to_order
    session[:cart].each do |item_id, quantity|
      OrderItem.create(order: @order, item_id: item_id, quantity: quantity)
    end
  end
end
