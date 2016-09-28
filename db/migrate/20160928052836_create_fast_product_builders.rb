class CreateFastProductBuilders < ActiveRecord::Migration
  def change
    create_table :fast_product_builders do |t|

      t.timestamps null: false
    end
  end
end
