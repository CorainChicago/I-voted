class PagesController < ApplicationController

  def index
    @general_voting_info= Electioninfo.all.sample(8)
  end

  def show
  end

  def fb
    render partial: 'pages/fb', layout: false
  end


end
