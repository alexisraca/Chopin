class LineItem < ActiveRecord::Base

  validates :statement_id, :product_id, :quantity, :total, presence: { message: "No puede estar en blanco" }

end
