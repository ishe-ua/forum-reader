# coding: utf-8
# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  account_id :integer
#  jabber     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_account_id  (account_id)
#  index_users_on_jabber      (jabber) UNIQUE
#
# Foreign Keys
#
#  fk_rails_61ac11da2b  (account_id => accounts.id)
#

##
# Пользователь приложения, по сути его профиль.
#
class User < ActiveRecord::Base
  belongs_to :account
end
