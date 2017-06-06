# Feed with forum.
#
# == Schema Information
#
# Table name: forums
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  name         :string
#  url          :string
#  target       :integer
#  position     :integer
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
#  fk_rails_...  (user_id => users.id)
#
class Forum < ApplicationRecord
  belongs_to :user

  include Name
  include Url
  include Target
  include Position
  include LastPostAt

  validates :url, uniqueness: { scope: :user_id }
  acts_as_list scope: :user
end
