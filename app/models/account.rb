# coding: utf-8
##
# Зарегистрированный аккаунт.
#
class Account < ActiveRecord::Base
  has_one :user
end
