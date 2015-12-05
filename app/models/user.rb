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

  attr_reader :district, :state_elections, :polling_place

  after_initialize :post_initialize

  def post_initialize
    @district = get_district
    @state_elections = StateElectionInfo.where("election_title LIKE ?", "%#{Zipcode.find_by(zip: self.zip).try(:state_name)}%")
    @polling_place = get_polling_place
  end

  def get_polling_place
    raw_polling_data = Zipcode.get_polling_place(("#{self.street_address} #{self.city}, #{self.state}").gsub(' ', "%20"))['address']
    if raw_polling_data['locationName']
      @polling_place = raw_polling_data['locationName'] + ', ' + raw_polling_data['line1'] + '. ' +  raw_polling_data['city'] + ', ' + raw_polling_data['state'] + " " + raw_polling_data['zip']
    else
      return raw_polling_data
    end
  end

   # polling_place = Zipcode.get_polling_place(("#{@user.street_address} #{@user.city}, #{@user.state}").gsub(' ', "%20"))['address']
   #  if polling_place['locationName']
   #    @polling_place = polling_place['locationName'] + ', ' + polling_place['line1'] + '. ' +  polling_place['city'] + ', ' + polling_place['state'] + " " + polling_place['zip']
   #  else
   #    @polling_place = polling_place
   #  end


  def get_district
    Zipcode.get_district(("#{self.street_address} #{self.city}, #{self.state}").gsub(' ', "%20")).gsub('s\'s', 's\'')
  end


end
