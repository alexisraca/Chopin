class Statement < ActiveRecord::Base
  has_many :payments
  has_many :lineltems

end
