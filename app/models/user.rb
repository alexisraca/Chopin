class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :lockable, authentication_keys: [:username]

  validates :username, presence: true
  validates :username, uniqueness: true

  validates_confirmation_of :password

  validates :first_name, :last_name, :role, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  scope :non_master, -> { joins(:role).where("roles.priority IN (?)", [Role::ADMIN_ROLE, Role::SELLER_ROLE]) }

  has_many :orders
  has_many :branches
  has_many :inventories, through: :branches
  belongs_to :role
end

