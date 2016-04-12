# coding: utf-8
# Урл.
#
# Поле +url+ в таблице:
# * строка
# * непустое
#
module Url
  extend ActiveSupport::Concern

  ## Используемые http-протоколы.
  VALID_SCHEMES = %w(http https).freeze

  ## Валидный url.
  VALID_URL = '(https?://(?:www.|(?!www))[^ .]+.[^ ]{2,}|www.[^ ]+.[^ ]{2,})'
              .freeze

  included do
    before_validation :downcase_url,      if: 'url.present?'
    before_validation :add_http_or_https, if: 'url.present?'

    validates :url,

              presence: true,
              format: { with: /VALID_URL/ }
  end

  protected

  ## Опускаем в нижний регистр.
  def downcase_url
    self.url = url.downcase
  end

  ## Добавляем назву протокола из PROTOCOLS.
  def add_http_or_https
    b = false
    VALID_SCHEMES.each { |name| b = true if url.start_with?(name + '://') }
    self.url = 'http://' + url unless b
  end
end
