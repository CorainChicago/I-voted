class ApplicationMailer < ActionMailer::Base

  include Resque::Mailer
  default from: "reminder@ivoted.com"
  layout 'mailer'



end
