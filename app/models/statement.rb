class Statement < ActiveRecord::Base
  attr_accessor :user_id
  has_many :payments
  has_many :lineltems
  validates :order_id, :total, presence: { message: "No puede estar en blanco" }

  belongs_to :order
end
