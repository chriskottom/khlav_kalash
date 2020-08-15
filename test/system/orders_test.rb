require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  setup do
    @order = orders(:homer)
  end

  test "visiting the index" do
    visit_with_basic_auth orders_url, username: AUTH_USERNAME, password: AUTH_PASSWORD
    assert_selector "h1", text: "Orders"
  end

  test "creating a Order" do
    visit_with_basic_auth orders_url, username: AUTH_USERNAME, password: AUTH_PASSWORD
    click_on "New Order"

    select @order.country, from: "Country"
    fill_in "Email address", with: @order.email_address
    fill_in "First name", with: @order.first_name
    fill_in "Last name", with: @order.last_name
    fill_in "Postal code", with: @order.postal_code
    click_on "Pay $2.99"

    assert_text "Order was successfully created"
    click_on "New order"
  end

  test "updating a Order" do
    visit_with_basic_auth orders_url, username: AUTH_USERNAME, password: AUTH_PASSWORD
    click_on "Edit", match: :first

    select @order.country, from: "Country"
    fill_in "Email address", with: @order.email_address
    fill_in "First name", with: @order.first_name
    fill_in "Last name", with: @order.last_name
    click_on "Pay $2.99"

    assert_text "Order was successfully updated"
    click_on "Back"
  end

  test "destroying a Order" do
    visit_with_basic_auth orders_url, username: AUTH_USERNAME, password: AUTH_PASSWORD
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Order was successfully destroyed"
  end
end
