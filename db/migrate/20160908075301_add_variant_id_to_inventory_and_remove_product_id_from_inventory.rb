class AddVariantIdToInventoryAndRemoveProductIdFromInventory < ActiveRecord::Migration
  def change
    remove_column(:inventories, :product_id)
    add_column(:inventories, :variant_id, :integer)
  end
end
