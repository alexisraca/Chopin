class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.integer :priority
      t.string :name
      t.timestamps null: false
    end
  end
end
