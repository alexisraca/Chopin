class Variant < ActiveRecord::Base
  has_many :inventories, -> { order(created_at: :asc) }
  belongs_to :product
  validates :name, :price, presence: { message: "No puede estar en blanco" }

  accepts_nested_attributes_for :inventories
  validates_associated :inventories

  scope :common_variants, -> { where(main_variant: false) }
  scope :for_product, ->(product) { where(product_id: product) }

  def siblings_count
    self.class.unscoped.for_product(product_id).except(self).count
  end
    


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
