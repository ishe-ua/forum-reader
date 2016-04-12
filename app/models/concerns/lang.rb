# coding: utf-8
# Язык общения и интерфейса.
#
# Поле +lang+ в таблице:
# * строка
# * непустое
#
module Lang
  extend ActiveSupport::Concern

  ## Поддерживаемые языки (локали).
  SUPPORTED_LANGS = APP::LANGS

  included do
    validates :lang,
              presence: true,
              inclusion: { in: SUPPORTED_LANGS }
  end
end
