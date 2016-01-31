# coding: utf-8
# Фид в Letter -письме.
#
# == Schema Information
#
# Table name: letter_items
#
#  id           :integer          not null, primary key
#  letter_id    :integer
#  name         :string           not null
#  url          :string           not null
#  last_post_at :datetime
#  position     :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_letter_items_on_last_post_at  (last_post_at)
#  index_letter_items_on_letter_id     (letter_id)
#  index_letter_items_on_name          (name)
#  index_letter_items_on_url           (url)
#
# Foreign Keys
#
#  fk_rails_2b6fa86a3d  (letter_id => letters.id)
#
class LetterItem < ApplicationRecord
  belongs_to :letter
end
