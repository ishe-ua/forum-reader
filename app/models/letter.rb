# == Schema Information
#
# Table name: letters
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  name         :string           not null
#  d1           :boolean          default(FALSE), not null
#  d2           :boolean          default(FALSE), not null
#  d3           :boolean          default(FALSE), not null
#  d4           :boolean          default(FALSE), not null
#  d5           :boolean          default(FALSE), not null
#  d6           :boolean          default(FALSE), not null
#  d7           :boolean          default(FALSE), not null
#  hour         :integer          not null
#  minute       :integer          not null
#  last_post_at :datetime         not null
#  position     :integer          not null
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

class Letter < ActiveRecord::Base
  belongs_to :user
  has_many :items
end
