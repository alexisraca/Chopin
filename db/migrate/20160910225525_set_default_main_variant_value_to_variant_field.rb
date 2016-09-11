class SetDefaultMainVariantValueToVariantField < ActiveRecord::Migration
  def change
    change_column :variants, :main_variant, :boolean, default: false
  end
end
