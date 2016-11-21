class ChangePaymentsSettledAtDateToDatetime < ActiveRecord::Migration
  def change
    change_column :payments, :settled_at, :datetime
  end
end
