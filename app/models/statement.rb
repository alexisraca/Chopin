class Statement < ActiveRecord::Base
  attr_accessor :user_id
  has_many :payments
  has_many :line_items
  validates :order_id, :total, presence: { message: "No puede estar en blanco" }

  belongs_to :order

  def add_line_item(variant, kuantity = 1)
    new_line_item = line_items.build(
                      variant: variant,
                      quantity: kuantity,
                      total: variant.price * kuantity
                    )
    begin
      LineItem.transaction do
        raise ActiveRecord::RecordInvalid.new(new_line_item)
        new_line_item.save!
      end
    rescue ActiveRecord::RecordInvalid => exception
      self.errors.add(:producto, message: "tuvo un error al agregarse")
    end
    new_line_item
  end
end
