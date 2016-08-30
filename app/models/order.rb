class Order < ActiveRecord::Base
  validates :user_id, :state, presence: { message: "No puede estar en blanco" }

  belongs_to :user
  has_many :statements
end
