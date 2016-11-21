class Payment < ActiveRecord::Base

  COMPLETED = "completed" # completo, cuando settled_at tiene fecha y tiene saldo pagado
                        # { settled_at: "date", total: 32321 }
  INCOMPLETE = "incomplete" # deuda, cuando settled_at no tiene fecha pero hay saldo pagado
                            # { settled_at: nil, total: 1232132.32 }
  AMOUNT = "amount" # Por propositos de poder crear pagos sin ser settled_at ni saldo pagado
                      # { settled_at: nil, total: nil }

  PAYMENT_PAYPAL = "payment_paypal"
  PAYMENT_INVOICE = "payment_invoice"
  PAYMENT_CASH = "payment_cash"
  PAYMENT_CREDIT = "payment_credit"

  belongs_to :statement
  has_one :order, through: :statement

  validates :state, :statement_id, :type, :total, presence: true

  def payment_types
    %w(PAYMENT_PAYPAL.classify PAYMENT_INVOICE.classify PAYMENT_CASH.classify PAYMENT_CREDIT.classify)
  end

  def complete_payment
    value = true
    begin
      self.class.transaction do
        self.state = COMPLETED if state.blank?
        self.settled_at = DateTime.now
        save!
        statement.update_totals
        order.update_totals
      end
    rescue Exception, ActiveRecord::RecordInvalid
      value = false
    end
    value
  end
end
