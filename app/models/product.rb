class Product < ActiveRecord::Base
  has_many :variants
  has_many :inventories, through: :variants
  has_one :main_variant, -> { where(main_variant: true) }, class_name: "Variant"

  accepts_nested_attributes_for :main_variant, :variants

  delegate :name, :description, :price, :cost, to: :main_variant

  validates_associated :main_variant, :variants
end
