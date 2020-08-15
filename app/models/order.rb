class Order < ApplicationRecord
  before_create :set_defaults

  UNIT_PRICE_CENTS = 299
  CURRENCY = 'USD'.freeze

  def price
    Money.new(UNIT_PRICE_CENTS, CURRENCY)
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
end
