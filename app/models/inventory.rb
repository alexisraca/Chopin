class Inventory < ActiveRecord::Base
  belongs_to :variant
  belongs_to :branch
  has_one :product, through: :variant

  validates :quantity, presence: true
end
#
# variant_id
# quantity
# expiration_date