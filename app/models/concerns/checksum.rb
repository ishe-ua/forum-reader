# Check sum.
#
# For <tt>eliminate duplicates</tt> from FeedItem -s.
#
# Field +checksum+ in table:
# * string
#
module Checksum
  extend ActiveSupport::Concern

  included do
    validates :checksum,

              presence: true,
              uniqueness: { scope: :feed_id }

    before_validation :calc_and_set_checksum, if: :blank?
  end

  protected

  def calc_and_set_checksum
    s = if url.present?
          url
        else
          t = Time.zone.now.to_i
          t.to_s + rand(t).to_s
        end

    self.checksum = Digest::MD5.hexdigest(s)
  end
end
