require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @credentials = ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'password')
    @order = orders(:homer)
  end

  test "should get index" do
    get orders_url, headers: { Authorization: @credentials }

    assert_response :success
  end

  test "should get new" do
    get new_order_url

    assert_response :success
  end

  test "should create order" do
    order_params = {
      country: @order.country,
      email_address: @order.email_address,
      first_name: @order.first_name,
      last_name: @order.last_name,
      postal_code: @order.postal_code
    }

    assert_difference('Order.count') do
      post orders_url, params: { order: order_params }
    end

    created_order = Order.order(created_at: :desc).first
    assert_redirected_to order_permalink_url(created_order.permalink)
  end

  test "should show order" do
    get order_url(@order), headers: { Authorization: @credentials }

    assert_response :success
  end

  test "should get edit" do
    get edit_order_url(@order), headers: { Authorization: @credentials }

    assert_response :success
  end

  test "should update order" do
    order_params = {
      amount_cents: @order.amount_cents,
      country: @order.country,
      email_address: @order.email_address,
      first_name: @order.first_name,
      last_name: @order.last_name
    }
    patch order_url(@order), params: { order: order_params }, headers: { Authorization: @credentials }

    assert_redirected_to order_url(@order)
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete order_url(@order), headers: { Authorization: @credentials }
    end

    assert_redirected_to orders_url
  end
end
