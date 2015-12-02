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
    else flash[:error] = "Please enter a valid address."
      redirect_to root_path
    end
  end

  def getzipcode

    @zipcode = Zipcode.get_zipcode(params['address'])
    render partial: 'zipcodes/generate_code', layout: false
  end

end
