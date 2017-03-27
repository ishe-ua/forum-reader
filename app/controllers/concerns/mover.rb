# See Position, Resource
module Mover
  extend ActiveSupport::Concern

  included do
    before_action :set_resource, only: %i(move_up move_down)
  end

  def move_up
    resource_class.transaction do
      resource.move_higher
      render 'shared/move_up'
    end
  end

  def move_down
    resource_class.transaction do
      resource.move_lower
      render 'shared/move_down'
    end
  end
end
