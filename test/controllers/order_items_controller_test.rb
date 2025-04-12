require 'test_helper'

class OrderItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as(:manager)
    @item = FactoryBot.create(:item, name: "Cardinal Bread")
    @user_customer = FactoryBot.create(:user, role: 'customer')
    @customer = FactoryBot.create(:customer, user: @user_customer)
    @address = FactoryBot.create(:address, customer: @customer, recipient: 'Chloe Deng', is_billing: true)
    @order = FactoryBot.create(:order, address: @address, customer: @customer)
    @order_item = FactoryBot.create(:order_item, order: @order, item: @item, shipped_on: Date.current)
  end
  
  test "should get edit" do
    get edit_order_item_path(@order_item)
    assert_response :success
  end

  test "should update order_ite if valid" do
    patch order_item_path(@order_item), params: { order_item: { order_id: @order_item.order.id, item_id: @order_item.item.id, quantity: 5, shipped_on: @order_item.shipped_on } }
    assert_equal "Order items were revised in the system.", flash[:notice]
    assert_redirected_to order_path(@order_item.order)
  end

  test "should not update order_item if invalid" do
    patch order_item_path(@order_item), params: { order_item: {  order_id: @order_item.order.id, item_id: @order_item.item.id, quantity: nil, shipped_on: @order_item.shipped_on } }
    assert_template :edit
  end

  test "should destroy order when appropriate" do
    @order_item.shipped_on = nil
    @order_item.save
    assert_difference('OrderItem.count', -1) do
      delete order_item_path(@order_item)
    end
    assert_equal "Cardinal Bread was removed from this order.", flash[:notice]
    assert_redirected_to order_path(@order_item.order)
  end

  test "should not have generic routes or actions" do
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "order_items", action: "index") end
    deny OrderItemsController.new.respond_to?(:index)
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "order_items", action: "show", id: "#{@order_item.id}") end
    deny OrderItemsController.new.respond_to?(:show)
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "order_items", action: "new", id: "#{@order_item.id}") end
    deny OrderItemsController.new.respond_to?(:new)
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "order_items", action: "create", id: "#{@order_item.id}") end
    deny OrderItemsController.new.respond_to?(:create)
  end
  
end