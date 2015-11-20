require 'net/http'
require 'json'

class ZipcodesController < ApplicationController
  def show
    @zipcode = session[:zip]
    @polling_place = get_polling_place(address)
  end
end
