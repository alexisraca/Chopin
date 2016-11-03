class Statement < ActiveRecord::Base
  attr_accessor :user_id
  has_many :payments
  has_many :line_items
  has_many :variants, through: :line_items
  validates :order_id, :total, presence: { message: "No puede estar en blanco" }

  belongs_to :order

  def add_line_item(variant, kuantity = 1)
    new_line_item = nil
    begin
      LineItem.transaction do
        if variants.include?(variant)
          new_line_item = line_items.select { |li| li.variant == variant }.first
          new_line_item.quantity += kuantity
          new_line_item.save!
          new_line_item.update_totals
        else
          new_line_item = line_items.build(
                                      variant: variant,
                                      quantity: kuantity
                                    )
          new_line_item.update_totals
        end
        #raise ActiveRecord::RecordInvalid.new(new_line_item)
      end
    rescue ActiveRecord::RecordInvalid => exception
      self.errors.add(:producto, message: "tuvo un error al agregarse")
    end
    return new_line_item
  end

  def update_totals
    self.total = line_items.sum(:total)
    save!
  end

  def update_tree_totals
    value = true
    begin
      self.class.transaction do
        update_totals && order.update_totals
      end
    rescue Exception, ActiveRecord::RecordInvalid
      value = false
    end
    return value
  end
end
