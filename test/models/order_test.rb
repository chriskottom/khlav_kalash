require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  setup do
    @order = orders(:homer)
  end

  test "base model is valid" do
    assert @order.valid?
  end

  test "is invalid when #first_name is blank" do
    @order.first_name = ''

    assert @order.invalid?
    assert @order.errors.added? :first_name, :blank
  end

  test "is invalid when #country is blank" do
    @order.country = ''

    assert @order.invalid?
    assert @order.errors.added? :country, :blank
  end

  test "is invalid when #postal_code is blank" do
    @order.postal_code = ''

    assert @order.invalid?
    assert @order.errors.added? :postal_code, :blank
  end

  test "is invalid when #email_address is blank" do
    @order.email_address = ''

    assert @order.invalid?
    assert @order.errors.added? :email_address, :blank
  end
end
