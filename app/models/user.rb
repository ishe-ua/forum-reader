# coding: utf-8
# Account profile.
#
# == Schema Information
#
# Table name: users
#
#  id                        :integer          not null, primary key
#  account_id                :integer
#  nick                      :string           not null
#  jabber                    :string
#  jabber_confirmation_at    :datetime
#  jabber_confirmation_token :string
#  lang                      :string           not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
# Indexes
#
#  index_users_on_account_id                 (account_id)
#  index_users_on_jabber                     (jabber) UNIQUE
#  index_users_on_jabber_confirmation_at     (jabber_confirmation_at)
#  index_users_on_jabber_confirmation_token  (jabber_confirmation_token) UNIQUE
#  index_users_on_lang                       (lang)
#  index_users_on_nick                       (nick) UNIQUE
#
# Foreign Keys
#
#  fk_rails_61ac11da2b  (account_id => accounts.id)
#
class User < ApplicationRecord
  belongs_to :account

  has_many :forums
  has_many :letters

  after_initialize :set_default_values

  include Nick

  include Jabber
  include JabberConfirmation

  include Lang

  protected

  ## Значения по умолчанию.
  def set_default_values
    self.lang ||= I18n.default_locale
  end
end
