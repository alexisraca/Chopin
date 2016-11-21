class AddAmountToPayments < ActiveRecord::Migration
  def change
    add_column(:payments, :amount, :decimal, precision: 8, scale: 3, default: 0.0 )
    change_column(:payments, :total, :decimal, precision: 8, scale: 3, default: 0.0 )
  end
end
