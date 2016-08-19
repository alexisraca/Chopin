class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.text :comment
      t.date :completed_at
      t.float :total
      t.string :state
      t.timestamps null: false
    end
  end
end
