# coding: utf-8
# Письма для AccountsController.
#
class AccountsMailer < ApplicationMailer
  ## Наше приветствие новеньким.
  def welcome(account)
    @account = account
    mail to: account.email
  end

  ## Письмо со ссылкой для подтверждения Email.
  def email_confirmation(account)
    @account = account
    mail to: account.email
  end

  ## Высылаем Account -у его новый Password.
  def new_password(account, new_password)
    @new_password = new_password
    mail to: account.email
  end
end
