class ZipcodesController < ApplicationController
  def show
    @zipcode = session[:zip]
  end

end