# coding: utf-8
# "Письма в редакцию", т.е. служебные админу.
#
# <b>Увага:</b>
#
# Все служебные письма (в т.ч. других mailer-ов) направляем admin-у, а
# тот уже перенаправляет их (по header-у) кому надо.
#
class AdminMailer < ApplicationMailer
  # :stopdoc:
  default to: APP::ADMIN_EMAIL
  # :startdoc:

  ## Зарегистрирован новый аккаунт.
  def new_registration(account)
    @account = account
    mail subject: "#{APP::NAME}: new registration"
  end

  ## Статистика проекта.
  def stats
    mail subject: "#{APP::NAME}: stats"
  end
end
