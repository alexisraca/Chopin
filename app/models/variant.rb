class Variant < ActiveRecord::Base
  has_many :inventories, -> { order(created_at: :asc) }
  belongs_to :product
  validates :name, :price, presence: { message: "No puede estar en blanco" }

  accepts_nested_attributes_for :inventories
  validates_associated :inventories

  attr_accessor :variants_count

  scope :common_variants, -> { where(main_variant: false) }
  scope :for_product, ->(product) { where(product_id: product) }
  
  scope :count_variants, -> {
    select("variants.*, variants_count.count siblings_count").
    joins(
      "INNER JOIN ("\
      "SELECT variants.product_id, count(variants.product_id) "\
      "FROM variants "\
      "group by variants.product_id) AS variants_count "\
      "on variants.product_id = variants_count.product_id"
    )
  }
#  scope :count_variants, -> {
#    select("variants.*, variants_count.count siblings_count").
#    joins(
#      "INNER JOIN ("\
#      "SELECT variants.product_id, count(variants.product_id) "\
#      "FILTER (WHERE variants.main_variant = 'false') "\
#      "FROM variants "\
#      "GROUP BY variants.product_id) AS variants_count "\
#      "ON variants.product_id = variants_count.product_id "
#    )
#  }

  acts_as_paranoid
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
