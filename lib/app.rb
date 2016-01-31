# coding: utf-8
##
# Константы и настройки приложения.
#
# В основном программерские.
# Еще есть админские, но они в основном в "secrets.yml".
#
module APP
  ## Назва проекта одним словом.
  NAME = 'ReaderJ'

  ## Год начала разработки.
  YEAR = '2016'

  ## Founder проекта.
  AUTHOR = 'ishe_ua'

  ## Хост на котором все крутится.
  HOST = 'readerJ.com'

  ## Почта админа.
  ADMIN_EMAIL = 'in.shevkun@gmail.com'

  ## Почта "без ответа".
  NOREPLY_EMAIL = "no-reply@#{HOST}"

  ## Для test и development сред.
  DEFAULT_PASSWORD = '1234567'

  ## Поддерживаемые локали.
  LANGS = %w(en ru) # TODO: вытащить из application.rb

  ## Дефолтная (главная) языковая локаль.
  DEFAULT_LANG = 'ru'
end
