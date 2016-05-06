# User language (locale).
#
# Field +lang+ in table:
# * string
#
module Lang
  extend ActiveSupport::Concern

  SUPPORTED_LANGS = APP::LANGS

  included do
    after_initialize :set_default_lang

    validates :lang,
              presence: true,

              inclusion: { in: SUPPORTED_LANGS }
  end

  protected

  def set_default_lang
    self.lang ||= I18n.default_locale
  end
end
