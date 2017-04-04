unless defined?(Rails)
  require 'action_mailer'
  require 'active_support'

  require_relative '01_libs'
  require_relative '../../app/mailers/application_mailer.rb'

  Dir[File.expand_path('../../app/mailers/**/*.rb', __dir__)]
    .each { |f| require f }
end

###
#
#

am = ActionMailer::Base

am.default_options = { from: "#{APP::NAME} <#{APP::NOREPLY_EMAIL}>" }
am.default_url_options = { host: 'localhost', port: 3000 } if
  am.respond_to?(:default_url_options)

if defined?(Rails) && Rails.env.production?
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
