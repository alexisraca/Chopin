class RemoveFieldsFromProducts < ActiveRecord::Migration
  def change
    remove_column(:products, :cost)
    remove_column(:products, :price)
    remove_column(:products, :sku)

    add_column(:variants, :cost, :float)
    add_column(:variants, :sku, :string)
  end
end
