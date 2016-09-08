class Inventory < ActiveRecord::Base
  belongs_to :variant
end
#
# variant_id
# quantity
# expiration_date