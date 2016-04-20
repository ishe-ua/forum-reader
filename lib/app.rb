# coding: utf-8
# Константы и настройки приложения.
#
# Программерские, админские в "secrets.yml".
#
module APP
  ## Назва проекта одним словом.
  NAME = 'forum-reader'.freeze

  ## Описание проекта одной строкой.
  DESCRIPTION = 'RSS and ATOM to Email and Jabber'.freeze

  ## Год начала разработки.
  YEAR = '2014'.freeze

  ## Founder проекта.
  AUTHOR = 'ishe_ua'.freeze

  ## Хост на котором все крутится.
  HOST = 'forum-reader2.com'.freeze

  ## Почта админа.
  ADMIN_EMAIL = 'in.shevkun@gmail.com'.freeze

  ## Почта support-а.
  SUPPORT_EMAIL = "support@#{HOST}".freeze

  ## Почта "без ответа".
  NOREPLY_EMAIL = "no-reply@#{HOST}".freeze

  ## Для test и development сред.
  DEFAULT_PASSWORD = '1234567'.freeze

  ## Поддерживаемые локали.
  LANGS = %w(en ru uk).freeze
end
