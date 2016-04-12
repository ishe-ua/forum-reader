# coding: utf-8
# Feed for tracking.
#
# == Schema Information
#
# Table name: forums
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  name         :string           not null
#  url          :string           not null
#  target       :integer          not null
#  position     :integer          not null
#  last_post_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_forums_on_last_post_at  (last_post_at)
#  index_forums_on_target        (target)
#  index_forums_on_url           (url)
#  index_forums_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_99e32c35a4  (user_id => users.id)
#

class Forum < ApplicationRecord
  belongs_to :user
  include Name
end
