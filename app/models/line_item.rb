class LineItem < ActiveRecord::Base

  belongs_to :variant
  belongs_to :statement

  has_one :order, through: :statement

  validates :statement_id, :quantity, :variant_id, :total, presence: { message: "No puede estar en blanco" }

  def update_quantity(kuantity = nil)
    value = true
    begin
      transaction do
        self.assign_attributes(quantity: kuantity.to_i) unless kuantity.blank?
        update_totals
      end
    rescue Exception, ActiveRecord::RecordInvalid
      value = false
    end
    value
  end

  def update_totals
    self.total = variant.price * self.quantity
    save!
    statement.update_tree_totals
  end
end
