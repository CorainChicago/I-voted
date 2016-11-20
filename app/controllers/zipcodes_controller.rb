class ZipcodesController < ApplicationController
  require 'net/http'
  require 'json'

  def show
    @user_friendly_display = {true: "Yes", false: "No", nil: "No"}
    @zipcode = Zipcode.make_zipcode_object(params['zip'])
    if @zipcode.present?
      @user = User.new(zip: @zipcode[:zip])
      @user.post_initialize(@zipcode)
    else flash[:error] = "Please enter a valid address."
      redirect_to root_path
    end
  end

  def getzipcode
    @zipcode = Zipcode.get_zipcode(params['address'])
    render partial: 'zipcodes/generate_code', layout: false
  end

end
