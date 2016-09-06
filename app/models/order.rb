class Order < ActiveRecord::Base

  CANCELED = "canceled"
  CUSTOMER = "customer"
  SUMMARY  = "summary"
  COMPLETE = "complete"
  PAYMENT  = "payment"

  STATES = [CANCELED, CUSTOMER, COMPLETE, SUMMARY, PAYMENT]

  validates :user_id, :state, presence: { message: "No puede estar en blanco" }

  belongs_to :user
  has_many :statements
end
