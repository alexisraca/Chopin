module Admin::InventoriesHelper
  def inventory_id_data_attr(inventory)
    return "" if inventory.new_record?
    "data-inventory-id=#{inventory.id}"
  end
end
