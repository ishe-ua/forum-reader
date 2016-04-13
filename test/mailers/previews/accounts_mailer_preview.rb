# Preview all emails at
# http://localhost:3000/rails/mailers/accounts_mailer
class AccountsMailerPreview < ActionMailer::Preview
  def welcome
    klass.welcome(account)
  end

  def email_confirmation
    klass.email_confirmation(account)
  end

  def new_password
    klass.new_password(account, 'aa23Gs')
  end

  private

  def klass
    AccountsMailer
  end

  def account
    Account.all.sample
  end
end
