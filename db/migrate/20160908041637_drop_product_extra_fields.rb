class DropProductExtraFields < ActiveRecord::Migration
  def change
  remove_column(:products, :name)
  remove_column(:products, :description)
  end
end
