class OrderItemsController < ApplicationController
  before_action :set_order_item, only: [:edit, :update, :destroy]

  def edit
  end

  def update
    if @order_item.update(order_item_params)
      flash[:notice] = "Order items were revised in the system."
      redirect_to order_path(@order_item.order)
    else
      render :edit
    end
  end

  def destroy
    if @order_item.shipped_on.nil? && @order_item.order.payment_receipt.nil?
      item_name = @order_item.item.name
      @order_item.destroy
      flash[:notice] = "#{item_name} was removed from this order."
    else
      flash[:error] = "This item has been shipped or paid for and cannot be removed."
    end
    redirect_to order_path(@order_item.order)
  end

  private

  def set_order_item
    @order_item = OrderItem.find(params[:id])
  end

  def order_item_params
    params.require(:order_item).permit(:order_id, :item_id, :quantity, :shipped_on)
  end
end
