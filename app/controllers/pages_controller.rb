class PagesController < ApplicationController

  def index
    @general_voting_info = Electioninfo.all.sample(8)
    @user = User.last
    send_reminders_email
  end

  def show
  end

end
