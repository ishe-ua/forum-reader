require 'test_helper'

class ContactsMailerTest < ActionMailer::TestCase
  setup do
    @mailer = ContactsMailer
    @contact = contacts([:one, :two].shuffle.sample)
  end

  test 'thank_you' do
    mail = mailer.thank_you(@contact)
    assert I18n.t('thank_you').present?

    assert_equal [@contact.email], mail.to
    assert_equal [APP::NOREPLY_EMAIL], mail.from
  end

  test 'to_us' do
    mail = mailer.to_us(@contact)
    assert_equal [APP::ADMIN_EMAIL], mail.to
    assert_equal [APP::NOREPLY_EMAIL], mail.from
  end
end
