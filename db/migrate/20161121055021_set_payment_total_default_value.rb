class SetPaymentTotalDefaultValue < ActiveRecord::Migration
  def change
    change_column_default(:payments, :total, 0.0)
  end
end
