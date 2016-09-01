class Product < ActiveRecord::Base
  validates :name, presence: { message: "No puede estar en blanco" }
  end
end
