class Product < ActiveRecord::Base
  has_many :variants
  has_many :inventories, through: :variants
  has_many :common_variants, -> { where(main_variant: false) }, class_name: "Variant"
  belongs_to :fast_product_builder
  has_one :main_variant, -> { where(main_variant: true) }, class_name: "Variant"

  accepts_nested_attributes_for :main_variant, :variants, :common_variants

  delegate :name, :description, :sku, :price, :cost, to: :main_variant

  validates_associated :main_variant, :variants, :common_variants
end
