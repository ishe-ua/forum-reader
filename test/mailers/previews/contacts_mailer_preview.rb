# Preview all emails at
# http://localhost:3000/rails/mailers/contacts_mailer
class ContactsMailerPreview < ActionMailer::Preview
  def thank_you
    klass.thank_you(contact)
  end

  def to_us
    klass.to_us(contact)
  end

  ###
  #
  #

  private

  def klass
    ContactsMailer
  end

  def contact
    Contact.all.shuffle.sample
  end
end
