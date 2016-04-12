# coding: utf-8
require 'test_helper'

class JabberConfirmationTest < ActiveSupport::TestCase
  setup do
    @instance = build(:user)
  end

  test '#jabber_confirmed?' do
    assert users(:igor).jabber_confirmed?
    assert_not instance.jabber_confirmed?
  end

  test '#jabber_confirm!' do
    instance.save
    assert_not instance.jabber_confirmed?

    assert instance.confirm_jabber!
    assert instance.jabber_confirmed?
  end

  test '#unconfirm_jabber' do
    users(:igor).unconfirm_jabber
    assert_not users(:igor).jabber_confirmed?
  end

  test 'два одинаковых токена не получится' do
    assert users(:igor).update(jabber_confirmation_token: 'aa')
    assert_not users(:john) .update(jabber_confirmation_token: 'aa')
  end

  test 'можем генерить случайные токены' do
    assert instance_class
      .gen_jabber_confirmation_token
  end
end
