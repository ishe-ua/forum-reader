# coding: utf-8
## Base model.
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
