class PagesController < ApplicationController

  def index
    @general_voting_info= Electioninfo.all.sample(8)
  end

  def show
  end


end
