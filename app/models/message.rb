# Incoming email (from Mailer::Piper).
#
# == Schema Information
#
# Table name: messages
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  from        :string
#  subject     :string
#  body        :text
#  attachments :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_messages_on_created_at  (created_at)
#  index_messages_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_273a25a7a6  (user_id => users.id)
#
class Message < ApplicationRecord
  belongs_to :user
  validates :from, presence: true
end
