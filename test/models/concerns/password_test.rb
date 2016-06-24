require 'test_helper'

class PasswordTest < ActiveSupport::TestCase
  setup do
    @instance = build(:account)
  end

  test 'required field' do
    instance.password = nil
    instance.password_confirmation = nil
    assert_not instance.valid?
  end

  test 'min length is limited' do
    instance.password = 'a' * (Password::MIN_PASSWORD - 1)
    instance.password_confirmation = instance.password
    assert_not instance.valid?
  end

  test 'max length is limited' do
    instance.password = 'a' * (Password::MAX_PASSWORD + 1)
    instance.password_confirmation = instance.password
    assert_not instance.valid?
  end

  test '#generate_random_password' do
    assert instance.class.generate_random_password.present?
  end
end
