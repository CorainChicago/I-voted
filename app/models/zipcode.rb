class Zipcode < ActiveRecord::Base
  has_many :candidates
  def self.get_polling_place(address)
    uri = URI.parse("https://www.googleapis.com/civicinfo/v2/voterinfo?key=#{ENV['API_KEY']}&address=#{address.gsub(' ', '%20')}&electionId=2000")
    response = JSON.parse(Net::HTTP.get(uri))
    return response['pollingLocations'][0] if response.length > 1
    {'locationName' => 'Sorry, we can\'t find a polling place for your location at this time. Please try a different address or check back closer to election day.'}
  end
end


