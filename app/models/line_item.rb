class LineItem < ActiveRecord::Base

  validates :statement_id, :quantity, :total, presence: { message: "No puede estar en blanco" }

end
