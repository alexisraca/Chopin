class Product < ActiveRecord::Base
  validates :name, presence: { message: "No puede estar en blanco" }
  has_many :variants
end

# Campos
#
# name - string
# description - text