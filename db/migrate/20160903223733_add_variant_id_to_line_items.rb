class AddVariantIdToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :variant_id, :integer
  end
end
