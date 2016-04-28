# coding: utf-8
# User message to us.
#
# == Some Attributes
#
# * +email+ Who wrote
#
#
# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  email      :string
#  theme      :string
#  text       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_contacts_on_email  (email)
#
class Contact < ApplicationRecord
  include Email
  include Theme
  include Text

  validates :theme, presence: true
  validates :text, presence: true

  default_scope { order 'created_at desc' }
end
