class ApplicationMailer < ActionMailer::Base
  default from: "ivoted@reminder.com"
  layout 'mailer'
end
