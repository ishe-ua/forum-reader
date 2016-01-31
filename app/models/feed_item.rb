# coding: utf-8
# Запись фида.
#
# == Schema Information
#
# Table name: feed_items
#
#  id         :integer          not null, primary key
#  feed_id    :integer
#  digest     :string           not null
#  date       :datetime
#  link       :text
#  titl       :text
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_feed_items_on_created_at          (created_at)
#  index_feed_items_on_feed_id             (feed_id)
#  index_feed_items_on_feed_id_and_digest  (feed_id,digest) UNIQUE
#
# Foreign Keys
#
#  fk_rails_0b1095a1ad  (feed_id => feeds.id)
#

class FeedItem < ActiveRecord::Base
  belongs_to :feed
end