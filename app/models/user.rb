class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :lockable, authentication_keys: [:username]

  validates :username, presence: { message: "No puede estar en blanco" }
end
