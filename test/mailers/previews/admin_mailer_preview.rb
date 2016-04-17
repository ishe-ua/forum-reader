# Preview all emails at
# http://localhost:3000/rails/mailers/admin_mailer
class AdminMailerPreview < ActionMailer::Preview
  def new_registration
    klass.new_registration(account)
  end

  delegate :stats, to: :klass

  private

  def klass
    AdminMailer
  end

  def account
    Account.all.sample
  end
end
