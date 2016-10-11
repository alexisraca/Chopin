class LineItem < ActiveRecord::Base

  belongs_to :variant
  belongs_to :line_item

  validates :statement_id, :quantity, :variant_id, :total, presence: { message: "No puede estar en blanco" }

end
