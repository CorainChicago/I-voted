class CandidatesController < ApplicationController
  def create
    puts "------"
    puts params
    puts "------"
    redirect_to "/zipcode/#{params[:zip]}"
  end
end