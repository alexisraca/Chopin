class Order < ActiveRecord::Base

  PAID = "paid"
  DEBT = "debt"
  CANCELED = "canceled"
  SUMARY  = "sumary"

  STATES = [PAID, DEBT, CANCELED, SUMARY]

  validates :user_id, :state, presence: { message: "No puede estar en blanco" }

  belongs_to :user
  has_many :statements

  def localized_state
    case state
      when PAID
        "Pagado"
      when DEBT
        "Deuda"
      when CANCELED
        "Cancelado"
      when SUMARY
        "Resumen"
    end
  end

  def update_totals
    self.total = statements.sum(:total)
    save!
  end
end
