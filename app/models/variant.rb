class Variant < ActiveRecord::Base
    validates :name, :price, presence: { message: "No puede estar en blanco" }
end
