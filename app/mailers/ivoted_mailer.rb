class IvotedMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.ivoted_mailer.reminder.subject
  #
  def reminder(user)
    @user = user
    mail(to: @user.email , subject: "Dont forget to vote")
  end

end
