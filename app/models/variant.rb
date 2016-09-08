class Variant < ActiveRecord::Base
  has_many :inventories
  validates :name, :price, presence: { message: "No puede estar en blanco" }

  accepts_nested_attributes_for :inventories
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