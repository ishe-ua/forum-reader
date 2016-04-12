# coding: utf-8
require 'test_helper'

class CountryTest < ActiveSupport::TestCase
  setup do
    @instance = build(:user)
  end

  test 'обязательное поле' do
    instance.country = nil
    assert_not instance.valid?
  end

  test 'код две буквы' do
    instance.country = 'aaa'
    assert_not instance.valid?
  end

  test 'можно только поддерживаемые страны' do
    instance.country = 'aa'
    assert_not instance.valid?
  end
end
