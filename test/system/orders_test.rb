require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  STRIPE_WAIT_TIME_SECONDS = 5

  setup do
    @order = orders(:homer)
  end

  test "visiting the index" do
    visit_with_basic_auth orders_url, username: AUTH_USERNAME, password: AUTH_PASSWORD
    assert_selector "h1", text: "Orders"
  end

  test "creating an Order" do
    visit root_url

    select @order.country, from: "Country"
    fill_in "Email address", with: @order.email_address
    fill_in "First name", with: @order.first_name
    fill_in "Last name", with: @order.last_name
    fill_in "Postal code", with: @order.postal_code

    using_wait_time(STRIPE_WAIT_TIME_SECONDS) do
      fill_stripe_elements(card: '4242 4242 4242 4242')

      click_on "Pay $2.99"

      assert_text "Order was successfully created"
    end

    click_on "New order"
  end

  test "creating an Order with SCA authorization" do
    visit root_url

    select @order.country, from: "Country"
    fill_in "Email address", with: @order.email_address
    fill_in "First name", with: @order.first_name
    fill_in "Last name", with: @order.last_name
    fill_in "Postal code", with: @order.postal_code

    using_wait_time(STRIPE_WAIT_TIME_SECONDS) do
      fill_stripe_elements(card: '4000 0027 6000 3184')

      click_on "Pay $2.99"

      complete_stripe_sca

      assert_text "Order was successfully created"
    end

    click_on "New order"
  end

  test "creating an Order with SCA failure" do
    visit root_url

    select @order.country, from: "Country"
    fill_in "Email address", with: @order.email_address
    fill_in "First name", with: @order.first_name
    fill_in "Last name", with: @order.last_name
    fill_in "Postal code", with: @order.postal_code

    using_wait_time(STRIPE_WAIT_TIME_SECONDS) do
      fill_stripe_elements(card: '4000 0027 6000 3184')

      click_on "Pay $2.99"

      fail_stripe_sca

      assert_text "We are unable to authenticate your payment method. Please choose a different payment method and try again."
    end
  end

  test "updating an Order" do
    visit_with_basic_auth orders_url, username: AUTH_USERNAME, password: AUTH_PASSWORD
    click_on "Edit", match: :first

    select @order.country, from: "Country"
    fill_in "Email address", with: @order.email_address
    fill_in "First name", with: @order.first_name
    fill_in "Last name", with: @order.last_name
    click_on "Update order"

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
