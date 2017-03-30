am = ActionMailer::Base
am.deliver_later_queue_name = 'mailer'

am.default_options = { from: "#{APP::NAME} <#{APP::NOREPLY_EMAIL}>" }
am.default_url_options = { host: 'localhost', port: 3000 }

if Rails.env.production?
  am.default_url_options = { host: "http://#{APP::HOST}" }
  am.delivery_method = :smtp

  am.smtp_settings = {
    address:              'smtp.gmail.com',
    port:                 587,
    domain:               APP::HOST,
    user_name:            Rails.application.secrets['smtp_username'],
    password:             Rails.application.secrets['smtp_password'],
    authentication:       'plain',
    enable_starttls_auto: true
  }
end
