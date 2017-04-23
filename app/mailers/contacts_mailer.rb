# Emails for ContactsController#create
class ContactsMailer < ApplicationMailer
  # In User locale if User exists or default locale if not.
  def thank_you(contact)
    @contact = contact

    account = Account.find_by(email: contact.email)
    l = account ? account.user.lang : I18n.default_locale

    I18n.with_locale(l) do
      mail to: @contact.email, subject: t('thank_you')
    end
  end

  # Duplicate to admin.
  def to_us(contact)
    @contact = contact
    mail to: APP::ADMIN_EMAIL, subject: 'EMAIL US from user'
  end
end
