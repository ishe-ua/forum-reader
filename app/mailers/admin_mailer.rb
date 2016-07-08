# Emails to APP admin.
class AdminMailer < ApplicationMailer
  default to: APP::ADMIN_EMAIL

  # New Account registratin
  def new_registration(account)
    @account = account
    mail subject: "#{APP::NAME}: new registration"
  end

  # App statistics
  def stats
    mail subject: "#{APP::NAME}: stats"
  end
end
