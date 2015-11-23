# Preview all emails at http://localhost:3000/rails/mailers/ivoted_mailer
class IvotedMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/ivoted_mailer/reminder
  def reminder
    user = User.last
    IvotedMailer.reminder(user)
  end

end
