# coding: utf-8
# Зарегистрированный аккаунт.
#
# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_accounts_on_email  (email) UNIQUE
#
class Account < ApplicationRecord
  has_one :user
end
