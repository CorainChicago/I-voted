class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :password, presence: true

end
