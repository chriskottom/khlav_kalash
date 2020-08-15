class Order < ApplicationRecord
  EMAIL_REGEXP = /\A[^@\s]+@[^@\s]+\z/
  UNIT_PRICE_CENTS = 299
  CURRENCY = 'USD'.freeze

  validates :first_name, :country, :postal_code, :email_address, presence: true
  validates :email_address, format: { with: EMAIL_REGEXP, message: 'Invalid email format' }

  before_create :set_defaults

  def price
    Money.new(UNIT_PRICE_CENTS, CURRENCY)
  end

  def payment_intent
    @payment_intent ||= find_or_create_payment_intent
  end

  private

  def set_defaults
    self.amount_cents = UNIT_PRICE_CENTS
    self.number = next_number
    self.permalink = SecureRandom.hex(20)

    while Order.where(permalink: self.permalink).any?
      self.permalink = SecureRandom.hex(20)
    end
  end

  def next_number
    current = self.class.reorder('number desc').first.try(:number) || '000000000000'
    current.next
  end

  def find_or_create_payment_intent
    if payment_intent_id
      Stripe::PaymentIntent.retrieve(payment_intent_id)
    else
      Stripe::PaymentIntent.create({
        amount: UNIT_PRICE_CENTS,
        currency: CURRENCY
      })
    end
  end
end
