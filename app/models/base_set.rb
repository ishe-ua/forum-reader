# Base for set-models.
class BaseSet < ApplicationRecord
  self.abstract_class = true

  belongs_to :user
  validates :user_id, presence: true, uniqueness: true

  include Status
end
