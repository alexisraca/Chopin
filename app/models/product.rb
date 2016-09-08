class Product < ActiveRecord::Base
  has_many :variants
end

# Campos
#
# name - string
# description - text
