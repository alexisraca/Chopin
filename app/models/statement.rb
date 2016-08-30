class Statement < ActiveRecord::Base
  has_many :payments
  has_many :lineltems
  validates :order_id, :state, :total, presence: { message: "No puede estar en blanco" }

  belongs_to :order
end
