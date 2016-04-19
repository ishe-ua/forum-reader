# coding: utf-8
# Настройки Reader -а.
#
# == Schema Information
#
# Table name: reader_confs
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  status     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_reader_confs_on_status   (status)
#  index_reader_confs_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_d4738ebb55  (user_id => users.id)
#
class ReaderConf < Conf
  belongs_to :user
  validates :user_id, presence: true, uniqueness: true

  include Status
end
