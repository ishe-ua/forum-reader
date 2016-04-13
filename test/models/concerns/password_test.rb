# coding: utf-8
require 'test_helper'

class PasswordTest < ActiveSupport::TestCase
  setup do
    @instance = build(:account)
  end

  test 'обязательное поле' do
    instance.password = nil
    instance.password_confirmation = nil
    assert_not instance.valid?
  end

  test 'минимальная длинна ограничена' do
    instance.password = 'a' * (Password::MIN_PASSWORD - 1)
    instance.password_confirmation = instance.password
    assert_not instance.valid?
  end

  test 'максимальная тоже' do
    instance.password = 'a' * (Password::MAX_PASSWORD + 1)
    instance.password_confirmation = instance.password
    assert_not instance.valid?
  end

  test 'можем сгенерить случайный пароль' do
    assert instance_class.gen_random_password.present?
  end
end
