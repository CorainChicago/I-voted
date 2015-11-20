require 'net/http'
require 'json'

class ZipcodesController < ApplicationController

  def show
    @zipcode = session[:zip]
    @zip = Zipcode.find_by(zip: @zipcode)
    @voter_registration_data = StateVotingInformation.find_by(name: @zip.state_name)
  end
end
