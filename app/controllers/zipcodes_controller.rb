class ZipcodesController < ApplicationController
  require 'net/http'
  require 'json'

  def show
    @user_friendly_display = {true: "Yes", false: "No", nil: "No"}
    @zip = params["zip"]
    @zipcode = Zipcode.make_zipcode_object(@zip)
    if @zipcode.present?
      @user = User.new(zip: @zip)
    else flash[:error] = "Please enter a valid address."
      redirect_to root_path
    end
  end

  def getzipcode
    @zipcode = Zipcode.get_zipcode(params['address'])
    render partial: 'zipcodes/generate_code', layout: false
  end

end
