# APP constants
module APP
  NAME = 'forum-reader'.freeze

  HOST = 'forum-reader2.com'.freeze

  DESCRIPTION = 'RSS and ATOM to Email and Jabber'.freeze

  FOUNDER = 'ishe_ua'.freeze

  # Start development since
  SINCE = 2017

  ADMIN_EMAIL = 'in.shevkun@gmail.com'.freeze

  SUPPORT_EMAIL = "support@#{HOST}".freeze

  NOREPLY_EMAIL = "no-reply@#{HOST}".freeze

  # For test and development environments
  DEFAULT_PASSWORD = '1234567'.freeze

  # Supported locales (see Lang)
  LANGS = %w(en ru uk).freeze

  # Common password for +all+ botes (from +ENV+)
  BOTES_PASSWORD = ENV['botes_password']

  # See Schedule and Clockwork
  SUPPORTED_MINUTES = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55].freeze
end
