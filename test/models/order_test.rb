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

  test "is invalid when #email_address is not in a valid format" do
    @order.email_address = 'Homer.Simpson'
    assert @order.invalid?
    assert @order.errors.added? :email_address, "Invalid email format"

    @order.email_address = '@HomerSimpson'
    assert @order.invalid?
    assert @order.errors.added? :email_address, "Invalid email format"
  end

  test 'attempts to fetch Stripe::PaymentIntent when id is known' do
    intent_id = 'pi_xxxxxxxxxxx'

    retrieve_mock = Minitest::Mock.new
    retrieve_mock.expect(:call, nil, [intent_id])

    Stripe::PaymentIntent.stub :retrieve, retrieve_mock do
      @order.payment_intent_id = intent_id
      @order.payment_intent
    end

    retrieve_mock.verify
  end

  test 'attempts to create Stripe::PaymentIntent when id is not known' do
    create_mock = Minitest::Mock.new
    create_mock.expect(:call, nil, [{ amount: 299, currency: 'USD' }])

    Stripe::PaymentIntent.stub :create, create_mock do
      @order.payment_intent
    end

    create_mock.verify
  end
end
