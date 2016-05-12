# APP constants.
module APP
  NAME = 'forum-reader'.freeze

  DESCRIPTION = 'RSS and ATOM to Email and Jabber'.freeze

  FOUNDER = 'ishe_ua'.freeze

  ## Start development since.
  SINCE = 2014

  HOST = 'forum-reader2.com'.freeze

  ADMIN_EMAIL = 'in.shevkun@gmail.com'.freeze

  SUPPORT_EMAIL = "support@#{HOST}".freeze

  NOREPLY_EMAIL = "no-reply@#{HOST}".freeze

  ## For test and development environments.
  DEFAULT_PASSWORD = '1234567'.freeze

  ## Supported locales (see Lang).
  LANGS = %w(en ru uk).freeze
end
