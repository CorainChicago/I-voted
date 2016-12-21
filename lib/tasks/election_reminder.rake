namespace :election_reminder do
  desc "Send election reminder emails"
  task send_reminders: :environment do
  	User.all.each do |user|
  		IvotedMailer.reminder(user).deliver
	end
  end

end
