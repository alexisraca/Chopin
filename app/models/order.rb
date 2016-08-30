class Order < ActiveRecord::Base

   belongs_to :user

   validates :user_id, :state, presence: { message: "No puede estar en blanco" }

end
