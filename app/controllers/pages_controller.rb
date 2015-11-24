class PagesController < ApplicationController

  def index
    @general_voting_info = Electioninfo.all.sample(8)
    @user = User.last
    send_reminders_email
  end

  def show
  end




  def send_reminders_email
    date = Date.parse("%#{DateTime.now.day} %#{DateTime.now.mon}")
    if date.mon == 11 && date.day == 23
      User.all.each do |user|
        if  !user.reminder_emails.last.nil? && user.reminder_emails.last.subject != "elections coming up"
          IvotedMailer.reminder(user).deliver
          ReminderEmail.create(user_id: user.id, subject: "elections coming up")
        end
      end
    end
  end


end
