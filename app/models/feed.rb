# coding: utf-8
# Фид, который скачиваем.
#
# == Schema Information
#
# Table name: feeds
#
#  id            :integer          not null, primary key
#  url           :string           not null
#  last_fetch_at :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_feeds_on_last_fetch_at  (last_fetch_at)
#  index_feeds_on_url            (url) UNIQUE
#
class Feed < ApplicationRecord
  has_many :feed_items

  ## Alias.
  def items
    feed_items
  end
end
