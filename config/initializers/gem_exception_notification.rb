require 'exception_notification/rails'

ExceptionNotification.configure do |config|
  # Adds a condition to decide when an exception must be ignored or not.
  # The ignore_if method can be invoked multiple times to add extra conditions.
  config.ignore_if do |_exception, _options|
    Rails.env.development? || Rails.env.test?
  end

  # Email notifier sends notifications by email.
  config.add_notifier :email,
                      email_prefix: '[ERROR] ',
                      sender_address: %("#{APP::NAME}" <#{APP::NOREPLY_EMAIL}>),
                      exception_recipients: [APP::ADMIN_EMAIL]
end
