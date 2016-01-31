# coding: utf-8
# Фид, который скачиваем.
#
# == Schema Information
#
# Table name: feeds
#
#  id         :integer          not null, primary key
#  url        :string           not null
#  fetched_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_feeds_on_fetched_at  (fetched_at)
#  index_feeds_on_url         (url) UNIQUE
#
class Feed < ActiveRecord::Base
  has_many :entries
end
