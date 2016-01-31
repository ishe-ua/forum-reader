# coding: utf-8
# Базовая модель.
#
# Все остальные наследуются от нее.
#
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
