class Variant < ActiveRecord::Base
  has_many :inventories, -> { order(created_at: :asc) }
  belongs_to :product
  validates :name, :price, presence: { message: "No puede estar en blanco" }

  accepts_nested_attributes_for :inventories
  validates_associated :inventories

  scope :common_variants, -> { where(main_variant: false) }
end
#
# Variants
#
# product_id - auto
# name - string
# description - text
# cost - float
# price - float
# sku - string