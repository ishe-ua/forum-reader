# coding: utf-8
# Url фида, который скачиваем.
#
# == Schema Information
#
# Table name: feeds
#
#  id            :integer          not null, primary key
#  url           :string
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
  has_many :feed_items, dependent: :destroy

  include Url
  validates :url, uniqueness: true
end
