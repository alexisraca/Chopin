class CreateVariants < ActiveRecord::Migration
  def change
    create_table :variants do |t|
      t.string :name
      t.text :description
      t.boolean :main_variant
      t.float :price
      t.timestamps null: false
    end
  end
end
