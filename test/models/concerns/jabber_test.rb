# coding: utf-8
require 'test_helper'

class JabberTest < ActiveSupport::TestCase
  setup do
    @instance = build(:user)
  end

  test 'обязательное поле' do
    instance.jabber = nil
    assert_not instance.valid?
  end

  test 'уникальное' do
    instance.jabber = instance_class.all.sample.jabber
    assert_not instance.valid?
  end

  test 'можно только валидные ящики' do
    instance.jabber = 'not-jabber'
    assert_not instance.valid?

    assert_equal(
      instance.errors[:jabber].first,
      I18n.t('activerecord.errors.invalid_format')
    )
  end

  test 'i18n-cообщение о неверном формате прописано' do
    msg = I18n.t('activerecord.errors.invalid_format')
    assert msg.present?
  end

  test 'перед валидацией переводится в нижний регистр' do
    instance.jabber = 'UseR@exAmple.COM'
    instance.validate
    assert_equal instance.jabber, 'user@example.com'
  end

  test '#nullify_jabber_confirmation' do
    user = users(:mary)
    assert user.jabber_confirmed?

    user.update(jabber: 'test@example.com')
    assert_not user.reload.jabber_confirmed?
  end
end
