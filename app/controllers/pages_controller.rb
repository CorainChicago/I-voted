class PagesController < ApplicationController

  def index
    @general_voting_info= Electioninfo.all.sample(8)
    @user = User.last
    send_reminders_email
  end

  def show
  end




  def send_reminders_email
    date = Date.parse("%#{DateTime.now.day} %#{DateTime.now.mon}")
    if date.mon == 11 && date.day == 23
      User.all.each do |user|

        IvotedMailer.reminder(user).deliver
      end
    end
  end


end
