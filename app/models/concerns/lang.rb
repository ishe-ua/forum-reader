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
    after_initialize :set_default_lang

    validates :lang,
              presence: true,

              inclusion: { in: SUPPORTED_LANGS }
  end

  protected

  ## Значение по умолчанию.
  def set_default_lang
    self.lang ||= I18n.default_locale
  end
end
