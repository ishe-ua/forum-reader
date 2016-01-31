# == Schema Information
#
# Table name: items
#
#  id           :integer          not null, primary key
#  letter_id    :integer
#  name         :string           not null
#  url          :string           not null
#  last_post_at :datetime         not null
#  position     :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_items_on_last_post_at  (last_post_at)
#  index_items_on_letter_id     (letter_id)
#  index_items_on_name          (name)
#  index_items_on_url           (url)
#
# Foreign Keys
#
#  fk_rails_8fa78c900a  (letter_id => letters.id)
#

class Item < ActiveRecord::Base
  belongs_to :letter
end
