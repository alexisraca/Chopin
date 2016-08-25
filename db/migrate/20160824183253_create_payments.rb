class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.float :total
      t.date :settled_at
      t.string :state
      t.integer :statement_id
      t.timestamps null: false
    end
  end
end
