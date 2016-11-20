class ZipcodesController < ApplicationController
  require 'net/http'
  require 'json'


  def show
    puts "here's the params! #{params['zip']}"
    @user_friendly_display = {true: "Yes", false: "No", nil: "No"}
    @zip = params["zip"]
    @zipcode = Zipcode.find_by(zip: @zip)
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
