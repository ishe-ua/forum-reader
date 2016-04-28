# coding: utf-8
## Common settings for set-models.
class BaseSet < ActiveRecord::Base
  self.abstract_class = true

  belongs_to :user
  validates :user_id, presence: true, uniqueness: true

  include Status
end
