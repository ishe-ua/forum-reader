require 'test_helper'

class JabberTest < ActiveSupport::TestCase
  setup do
    @instance = build(:user)
  end

  test 'not required field' do
    instance.jabber = nil
    assert instance.valid?
  end

  test 'unique field' do
    instance.jabber = instance.class.all.sample.jabber
    assert_not instance.valid?
  end

  test 'only valid jabber ids' do
    instance.jabber = 'not-jabber'
    assert_not instance.valid?

    assert_equal(
      instance.errors[:jabber].first,
      I18n.t('activerecord.errors.invalid_format')
    )
  end

  test 'i18n error message is present' do
    msg = I18n.t('activerecord.errors.invalid_format')
    assert msg.present?
  end

  test 'downcase before validation' do
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
