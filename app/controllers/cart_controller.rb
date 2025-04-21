class CartController < ApplicationController
  before_action :initialize_cart

  def view
    @items_in_cart = load_items_from_cart
    @subtotal = calculate_subtotal
    @shipping_cost = 2.00
    @total = @subtotal + @shipping_cost
  end

  def add_item
    item_id = params[:id].to_s
    session[:cart][item_id] ||= 0
    session[:cart][item_id] += 1

    item = Item.find(item_id)
    flash[:notice] = "#{item.name} was added to cart."
    # redirect_to view_cart_path
    redirect_back(fallback_location: items_path)

  end

  def remove_item
    item_id = params[:id].to_s
    session[:cart].delete(item_id)

    item = Item.find(item_id)
    flash[:notice] = "#{item.name} was removed from cart."
    redirect_to view_cart_path
  end

  def empty
    session[:cart] = {}
    flash[:notice] = "Cart is emptied."
    redirect_to view_cart_path
  end

  def checkout
    @items_in_cart = load_items_from_cart
    @subtotal = calculate_subtotal
    @shipping_cost = 5.00
    @total = @subtotal + @shipping_cost
    @addresses = current_user.customer.addresses.active
    @order = Order.new(customer_id: current_user.customer.id)
  end

  private

  def initialize_cart
    session[:cart] ||= {}
  end

  def load_items_from_cart
    session[:cart].map do |item_id, quantity|
      item = Item.find(item_id)
      price = item.current_price
      [item, quantity, price]
    end
  end

  def calculate_subtotal
    load_items_from_cart.sum { |item, quantity, price| quantity * price.to_f }
  end
end
