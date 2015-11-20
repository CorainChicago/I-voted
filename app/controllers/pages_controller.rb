class PagesController < ApplicationController

  def index
    @general_voting_info = Electioninfo.all
    # load_zip_codes
  end


end
