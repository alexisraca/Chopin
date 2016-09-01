class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :lockable, authentication_keys: [:username]

  validates :username, presence: { message: "No puede estar en blanco" }
  validates_confirmation_of :password
  has_many :orders
  validates :first_name, :last_name, presence: { message: "No puede estar en blanco" }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
end

