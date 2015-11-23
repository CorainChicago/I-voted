class ApplicationMailer < ActionMailer::Base

  include Resque::Mailer
  default from: "ivoted@reminder.com"
  layout 'mailer'
end
