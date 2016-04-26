# coding: utf-8
# Письмо.
#
# Группа LetterItem -фидов.
#
#
# == Schema Information
#
# Table name: letters
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  name         :string
#  d1           :boolean
#  d2           :boolean
#  d3           :boolean
#  d4           :boolean
#  d5           :boolean
#  d6           :boolean
#  d7           :boolean
#  hour         :integer
#  minute       :integer
#  last_post_at :datetime
#  position     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_letters_on_d1            (d1)
#  index_letters_on_d2            (d2)
#  index_letters_on_d3            (d3)
#  index_letters_on_d4            (d4)
#  index_letters_on_d5            (d5)
#  index_letters_on_d6            (d6)
#  index_letters_on_d7            (d7)
#  index_letters_on_hour          (hour)
#  index_letters_on_last_post_at  (last_post_at)
#  index_letters_on_minute        (minute)
#  index_letters_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_0236efdee3  (user_id => users.id)
#
class Letter < ApplicationRecord
  belongs_to :user
  has_many :letter_items, dependent: :destroy

  include Name
  include Position
  include Schedule
  include LastPostAt

  acts_as_list scope: :user
end
