class Promotion < ActiveRecord::Base

  validates :start_date, :end_date, :name, :product_id, presence: { message: "No puede estar en blanco" }

end
