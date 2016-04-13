# coding: utf-8
require 'test_helper'

class EmailConfirmationTest < ActiveSupport::TestCase
  setup do
    @instance = build(:account)
  end

  test '#email_confirmed?' do
    assert accounts(:igor).email_confirmed?
    assert_not instance.email_confirmed?, 'по дефолту все не подтвержденные'
  end

  test '#email_confirm!' do
    instance.save
    assert_not instance.email_confirmed?

    assert instance.confirm_email!
    assert instance.email_confirmed?
  end

  test '#unconfirm_email' do
    accounts(:igor).unconfirm_email
    assert_not accounts(:igor).email_confirmed?
  end

  test 'два одинаковых токена не получится' do
    assert     accounts(:igor).update(email_confirmation_token: 'aa')
    assert_not accounts(:john).update(email_confirmation_token: 'aa')
  end
end
