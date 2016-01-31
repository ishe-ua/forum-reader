# coding: utf-8
##
# Пользователь приложения, по сути его профиль.
#
class User < ActiveRecord::Base
  belongs_to :account
end
