class PagesController < ApplicationController

  def index
    @general_voting_info = Electioninfo.all
  end

  def show
  end


end
