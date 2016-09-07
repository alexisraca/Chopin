class Product < ActiveRecord::Base
  has_many :variants
  validates :name, presence: { message: "No puede estar en blanco" }
end

# Campos
#
# name - string
# description - text
