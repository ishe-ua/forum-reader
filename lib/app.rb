# coding: utf-8
# frozen_string_literal: true
##
# Константы и настройки приложения.
#
# В основном программерские.
# Еще есть админские, но они в основном в "secrets.yml".
#
module APP
  ## Назва проекта одним словом.
  NAME = 'Reader'.freeze

  ## Год начала разработки.
  YEAR = '2016'.freeze

  ## Founder проекта.
  AUTHOR = 'ishe_ua'.freeze

  ## Хост на котором все крутится.
  HOST = 'feeds-reader.com'.freeze

  ## Почта админа.
  ADMIN_EMAIL = 'in.shevkun@gmail.com'.freeze

  ## Почта "без ответа".
  NOREPLY_EMAIL = "no-reply@#{HOST}".freeze

  ## Для test и development сред.
  DEFAULT_PASSWORD = '1234567'.freeze

  ## Поддерживаемые локали.
  LANGS = %w(en ru).freeze # TODO: вытащить из application.rb

  ## Дефолтная (главная) языковая локаль.
  DEFAULT_LANG = 'ru'.freeze
end
