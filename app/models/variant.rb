class Variant < ActiveRecord::Base
  validates :name, :price, presence: { message: "No puede estar en blanco" }
end
#
# Variants
#
# product_id - auto
# cost - float
# price - float
# sku - string