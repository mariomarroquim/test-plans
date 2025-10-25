class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("EMAIL_ADDRESS") { "admin@example.com" }

  layout "mailer"
end
