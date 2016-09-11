class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.string :name
      t.text :description
      t.integer :manager_id
      t.timestamps null: false
    end
  end
end
