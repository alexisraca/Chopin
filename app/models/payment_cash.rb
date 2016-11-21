class PaymentCash < Payment
  state_machine :initial => :summary do
    event :complete_payment do
      transition summary: :completed
    end

    event :cancel_payment do
      transition any => :void
    end

    event :unvoid_payment do
      transition void: :completed, if: ->(payment) { payment.total > 0.0 && !payment.settled_at.blank? }
      transition void: :summary, if: ->(payment) { payment.total == 0.0 }
    end
  end
end