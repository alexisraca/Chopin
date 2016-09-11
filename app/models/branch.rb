class Branch < ActiveRecord::Base
  belongs_to :manager, class_name: User
  has_many :inventories
  has_many :variants, through: :inventories

  validates :name, presence: true
end
