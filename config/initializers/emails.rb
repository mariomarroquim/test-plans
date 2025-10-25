# Be sure to restart your server when you modify this file.

# Email configuration for the application.
# This initializer sets up the Action Mailer to use SMTP with Gmail.

Rails.application.configure do
  config.action_mailer.delivery_method = :smtp

  config.action_mailer.smtp_settings = {
    address: ENV.fetch("EMAIL_SERVER") { "smtp.example.com" },
    port: 587,
    user_name: ENV.fetch("EMAIL_ADDRESS") { "admin@example.com" },
    password: ENV.fetch("EMAIL_PASSWORD") { "password" },
    authentication: "plain",
    enable_starttls_auto: true,
    enable_starttls: true,
    open_timeout: 10,
    read_timeout: 10
  }
end
