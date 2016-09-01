class Inventory < ActiveRecord::Base
	validates :product_id, :quantity, presence: { message: "No puede estar en blanco" }
end
