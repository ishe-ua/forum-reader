# coding: utf-8
require 'test_helper'

class JabberConfirmationTest < ActiveSupport::TestCase
  setup do
    @instance = build(:user)
  end

  test 'токен обязательно' do
    instance.jabber_confirmation_token = nil
    assert_not instance.valid?
  end

  test '#jabber_confirmed?' do
    assert users(:ishe).jabber_confirmed?
    assert_not instance.jabber_confirmed?
  end

  test '#jabber_confirm' do
    instance.save
    assert_not instance.jabber_confirmed?

    assert instance.confirm_jabber
    assert instance.jabber_confirmed?
  end

  test '#unconfirm_jabber' do
    users(:ishe).unconfirm_jabber
    assert_not users(:ishe).jabber_confirmed?
  end

  test 'два одинаковых токена не получится' do
    assert users(:ishe).update(jabber_confirmation_token: 'aa')
    assert_not users(:john) .update(jabber_confirmation_token: 'aa')
  end
end
