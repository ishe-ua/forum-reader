# coding: utf-8
## Настройки, общие для всех set-моделей.
class BaseSet < ActiveRecord::Base
  self.abstract_class = true

  belongs_to :user
  validates :user_id, presence: true, uniqueness: true

  include Status
end
