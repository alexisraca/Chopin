class Payment < ActiveRecord::Base

  COMPLETE = "complete" # completo, cuando settled_at tiene fecha y tiene saldo pagado
                        # { settled_at: "date", total: 32321 }
  INCOMPLETE = "incomplete" # deuda, cuando settled_at no tiene fecha pero hay saldo pagado
                            # { settled_at: nil, total: 1232132.32 }
  SUMMARY = "summary" # Por propositos de poder crear pagos sin ser settled_at ni saldo pagado
                      # { settled_at: nil, total: nil }

  validates :state, :statement_id, presence: { message: "No puede estar en blanco" }

  def complete_payment
    value = true
    begin
      self.class.transaction do
        self.state = COMPLETE if state.blank?
        save!
        statement.update_totals
        statement.order.update_totals
      end
    rescue Exception, ActiveRecord::RecordInvalid
      value = false
    end
    value
  end

end
