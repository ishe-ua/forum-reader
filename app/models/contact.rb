# coding: utf-8
# Контакт с нами.
#
# По сути это есть "Написать нам".
# Все сообщения сохраняем в базе, т.к. это enterprise-проект.
#
#
# == Some Attributes
#
# * +email+ От кого сообщение
#
#
# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  email      :string           not null
#  theme      :string           not null
#  text       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_contacts_on_email  (email)
#
class Contact < ApplicationRecord
  include Email
  include Text

  ## Максимальная длинна темы сообщения.
  MAX_THEME_LENGTH = 128

  default_scope { order 'created_at desc' }

  validates :theme, presence: true, length: { maximum: MAX_THEME_LENGTH }
  validates :text, presence: true
end
