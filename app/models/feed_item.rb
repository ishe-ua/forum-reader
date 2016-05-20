# Fetched item of Feed.
#
# == Schema Information
#
# Table name: feed_items
#
#  id         :integer          not null, primary key
#  feed_id    :integer
#  date       :datetime
#  url        :string
#  theme      :string
#  text       :text
#  checksum   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_feed_items_on_checksum    (checksum)
#  index_feed_items_on_created_at  (created_at)
#  index_feed_items_on_feed_id     (feed_id)
#
# Foreign Keys
#
#  fk_rails_0b1095a1ad  (feed_id => feeds.id)
#
class FeedItem < ApplicationRecord
  belongs_to :feed

  include Url
  include Theme
  include Text

  include Checksum
end
