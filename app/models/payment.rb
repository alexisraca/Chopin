class Payment < ActiveRecord::Base

  validates :total, :state, :statement_id, presence: { message: "No puede estar en blanco" }

end
