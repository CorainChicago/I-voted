class ZipcodesController < ApplicationController
require 'net/http'
require 'json'


  def show
    @user_friendly_display = {true: "Yes", false: "No", nil: "No"}
    @zipcode = params["zip"]
    @zip = Zipcode.find_by(zip: @zipcode)
    if @zip.present?
      @voter_registration_data = StateVotingInformation.find_by(name: @zip.state_name)
      @statewebsite = StateWebsite.find_by(name: @zip.state_name)
    else flash[:error] = "Please enter a 5-digit zipcode."
      redirect_to root_path
    end
  end

end
