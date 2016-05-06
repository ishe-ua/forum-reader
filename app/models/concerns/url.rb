# Field +url+ in table:
# * string
#
module Url
  extend ActiveSupport::Concern

  SUPPORTED_SCHEMES = %w(http https).freeze

  included do
    before_validation :downcase_url,      if: 'url.present?'
    before_validation :add_http_or_https, if: 'url.present?'

    validates :url,

              presence: true,
              format: { with: URI.regexp }
  end

  protected

  def downcase_url
    url.downcase!
  end

  ## Add scheme name from SUPPORTED_SCHEMES if absent.
  def add_http_or_https
    b = false
    SUPPORTED_SCHEMES.each { |name| b = true if url.start_with?(name + '://') }
    self.url = 'http://' + url unless b
  end
end
