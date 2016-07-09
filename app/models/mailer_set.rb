# Mailer settings.
#
# == Schema Information
#
# Table name: mailer_sets
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  status       :integer
#  last_post_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_mailer_sets_on_last_post_at  (last_post_at)
#  index_mailer_sets_on_status        (status)
#  index_mailer_sets_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_ae6ced02bb  (user_id => users.id)
#

class MailerSet < BaseSet
  include LastPostAt
end
