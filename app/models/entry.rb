# coding: utf-8
# Запись фида.
#
# == Schema Information
#
# Table name: entries
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Entry < ActiveRecord::Base
  belongs_to :feed
end
