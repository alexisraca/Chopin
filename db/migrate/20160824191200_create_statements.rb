class CreateStatements < ActiveRecord::Migration
  def change
    create_table :statements do |t|
      t.integer :order_id
      t.string :state
      t.float :total
      t.timestamps null: false
    end
  end
end
