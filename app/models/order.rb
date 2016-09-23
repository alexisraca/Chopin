class Order < ActiveRecord::Base

  CANCELED = "canceled"
  SUMMARY  = "summary"
  COMPLETE = "complete"
  PAYMENT  = "payment"

  STATES = [CANCELED, COMPLETE, SUMMARY, PAYMENT]

  validates :user_id, :state, presence: { message: "No puede estar en blanco" }

  belongs_to :user
  has_many :statements

  def localized_state
    case state
      when CANCELED
        "cancelado"
      when CUSTOMER
        "cliente"
      when SUMMARY
        "pendiente"
      when COMPLETE
        "completado"
      when PAYMENT
        "pago"
    end
  end
end
