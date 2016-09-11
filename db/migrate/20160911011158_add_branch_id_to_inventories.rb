class AddBranchIdToInventories < ActiveRecord::Migration
  def change
    add_column(:inventories, :branch_id, :integer)
  end
end
