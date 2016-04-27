# coding: utf-8
# Продолжение Position.
#
# Пользуемся Resource.
#
module Mover
  extend ActiveSupport::Concern

  included do
    before_action :set_resource, only: [
      :move_up,
      :move_down
    ]
  end

  ## Поднять выше.
  def move_up
    resource_class.transaction do
      resource.move_higher
      render 'shared/move_up'
    end
  end

  ## Опустить ниже.
  def move_down
    resource_class.transaction do
      resource.move_lower
      render 'shared/move_down'
    end
  end
end
