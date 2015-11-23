class User < ActiveRecord::Base
  has_many :reminder_emails
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :password, presence: true

end
