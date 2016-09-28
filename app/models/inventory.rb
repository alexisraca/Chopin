class Inventory < ActiveRecord::Base
  belongs_to :variant
  belongs_to :branch
  has_one :product, through: :variant
end
#
# variant_id
# quantity
# expiration_date