require 'net/http'
require 'json'

class ZipcodesController < ApplicationController

  def show
    @zipcode = params["zip"]
    @zip = Zipcode.find_by(zip: @zipcode)
    if @zip.present?
    @voter_registration_data = StateVotingInformation.find_by(name: @zip.state_name)
    else flash[:error] = "Please enter a 7-digit zipcode."
      redirect_to root_path
    end
  end
end
