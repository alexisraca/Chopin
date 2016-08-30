class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.date :start_date
      t.date :end_date
      t.string :name
      t.text :description
      t.integer :product_id
      t.timestamps null: false
    end
  end
end
