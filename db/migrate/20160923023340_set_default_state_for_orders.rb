class SetDefaultStateForOrders < ActiveRecord::Migration
  def change
    change_column(:orders, :state, :string, default: "summary")
  end
end
