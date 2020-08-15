class AddPaymentIntentIdToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :payment_intent_id, :string
    add_index :orders, :payment_intent_id, unique: true
  end
end
