require 'net/http'
require 'json'

class ZipcodesController < ApplicationController
  def show
    @zipcode = session[:zip]
    @polling_place = get_polling_place(@zipcode)
  end
  def self.get_polling_place(address)
    uri = URI.parse("https://www.googleapis.com/civicinfo/v2/voterinfo?key=#{ENV['API_KEY']}&address=#{address.gsub(' ', '%20')}&electionId=2000")
    @response = JSON.parse(Net::HTTP.get(uri))
    @response['pollingLocations']
  end
end
