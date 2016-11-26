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

  after_initialize :post_initialize

  attr_reader :district, :state_elections, :polling_place, :voter_registration_data, :candidates, :offices

  def post_initialize
    @district = get_district
    @state_elections = StateElectionInfo.where("election_title LIKE ?", "%#{Zipcode.make_zipcode_object(zip).try(:state_name)}%")
    @polling_place = get_polling_place
    @voter_registration_data = get_voter_registration_data
    @candidates = []
    @offices = []
  end

  def get_polling_place
    raw_polling_data = Zipcode.get_polling_place(("#{self.street_address} #{self.city}, #{self.state}").gsub(' ', "%20"))['address']
    if raw_polling_data['locationName']
      @polling_place = raw_polling_data['locationName'] + ', ' + raw_polling_data['line1'] + '. ' +  raw_polling_data['city'] + ', ' + raw_polling_data['state'] + " " + raw_polling_data['zip']
    else
      return raw_polling_data
    end
  end

  def get_voter_registration_data
    StateVotingInformation.find_by(name: Zipcode.make_zipcode_object(zip).try(:state_name))
  end

  def get_district
    Zipcode.get_district(("#{self.street_address} #{self.city}, #{self.state}").gsub(' ', "%20")).gsub('s\'s', 's\'')
  end

  def get_candidates
    Candidate.remove_appointed_politicians(@zip)
    @candidates = Candidate.where(zip: self.zip).where.not("name LIKE ?", "%#{Candidate.current_president}%")
  end

  def get_offices
    Candidate.get_offices(@candidates)
  end

end
