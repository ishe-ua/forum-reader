# coding: utf-8
# Номер элемента по списку.
#
# gem 'acts_as_list'
#
# Поле +position+ в таблице:
# * число
#
module Position
  extend ActiveSupport::Concern

  included do
    default_scope { order :position }
  end
end
