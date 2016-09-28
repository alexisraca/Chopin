class AddFastProductIdToProductsTable < ActiveRecord::Migration
  def change
    add_column(:products, :fast_product_builder_id, :integer)
  end
end
