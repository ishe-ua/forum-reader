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

    before_validation :calc_and_set_checksum, if: 'checksum.blank?'
  end

  protected

  def calc_and_set_checksum
    s = "#{url}-#{theme}-#{text}"
    self.checksum = Digest::MD5.hexdigest(s)
  end
end
