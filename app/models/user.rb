require_relative 'zipcode.rb'

class User < ActiveRecord::Base
  has_many :reminder_emails
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :token, uniqueness: true
  validates_presence_of :zip
  validates_length_of :zip, minimum: 5, too_short: 'please enter at least 5 characters'
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :password, presence: true, :on => :create

  attr_reader :district
  after_initialize :get_district


  def get_district
    @district = Zipcode.get_district(("#{self.street_address} #{self.city}, #{self.state}").gsub(' ', "%20")).gsub('s\'s', 's\'')
  end


end
