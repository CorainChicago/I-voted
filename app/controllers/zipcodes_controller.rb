require 'net/http'
require 'json'

class ZipcodesController < ApplicationController
  def show
    @zipcode = session[:zip]
    @polling_place = get_polling_place(@zipcode)
  end
  def get_polling_place(zipcode)
    uri = URI.parse('https://www.googleapis.com/civicinfo/v2/elections?key=AIzaSyDkn2kz-xb9COWfsqSVkSePa2G7yHbXnxY')
    @response = JSON.parse(Net::HTTP.get(uri))
    puts @response
  end
end