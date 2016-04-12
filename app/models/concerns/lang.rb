# coding: utf-8
# Язык общения и интерфейса.
#
# Поле +lang+ в таблице:
# * строка
#
module Lang
  extend ActiveSupport::Concern

  ## Поддерживаемые языки (локали).
  SUPPORTED_LANGS = APP::LANGS

  included do
    validates :lang,
              inclusion: { in: SUPPORTED_LANGS }
  end
end
