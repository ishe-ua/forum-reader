# coding: utf-8
require 'test_helper'

class EmailTest < ActiveSupport::TestCase
  setup do
    @instance = build(:account)
  end

  test 'обязательное поле' do
    instance.email = nil
    assert_not instance.valid?
  end

  test 'уникальное' do
    instance.email = instance_class.all.sample.email
    assert_not instance.valid?
  end

  test 'можно только валидные ящики' do
    instance.email = 'not-email'
    assert_not instance.valid?

    assert_equal(
      instance.errors[:email].first,
      I18n.t('activerecord.errors.invalid_format')
    )
  end

  test 'i18n-cообщение о неверном формате прописано' do
    msg = I18n.t('activerecord.errors.invalid_format')
    assert msg.present?
  end

  test 'перед валидацией переводится в нижний регистр' do
    instance.email = 'UseR@exAmple.COM'
    instance.validate
    assert_equal instance.email, 'user@example.com'
  end

  test '#nullify_email_confirmation' do
    acc = accounts(:mary)
    assert acc.email_confirmed?

    acc.update(email: 'test@example.com')
    assert_not acc.reload.email_confirmed?
  end
end
