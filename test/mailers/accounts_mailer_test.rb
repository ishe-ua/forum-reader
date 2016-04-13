require 'test_helper'

class AccountsMailerTest < ActionMailer::TestCase
  setup do
    @account = accounts(:john)
    @mailer = AccountsMailer
  end

  teardown do
    assert mail.subject.present?
    assert mail.from.present?
  end

  test '#welcome' do
    @mail = mailer.welcome(@account)
    assert I18n.t('accounts_mailer.welcome.subject').present?

    assert_equal [@account.email], mail.to
    assert_match APP::NAME, mail.body.encoded
  end

  test '#email_confirmation' do
    @mail = mailer.email_confirmation(@account)
    assert_equal [@account.email], mail.to
    assert I18n.t('accounts_mailer.email_confirmation.subject').present?
  end

  test '#new_password' do
    @mail = mailer.new_password(@account, 'aassACd2')
    assert I18n.t('accounts_mailer.new_password.subject').present?

    assert_equal [@account.email], mail.to
    assert_match 'aassACd2',       mail.body.encoded
  end
end
