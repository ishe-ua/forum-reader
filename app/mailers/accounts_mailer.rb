# See AccountsController
class AccountsMailer < ApplicationMailer
  def welcome(account)
    @account = account
    mail to: account.email
  end

  def email_confirmation(account)
    @account = account
    mail to: account.email
  end

  def jabber_confirmation(account)
    @account = account
    mail to: account.user.jabber
  end

  # Send new Password to Account
  def new_password(account, new_password)
    @new_password = new_password
    mail to: account.email
  end
end
