# coding: utf-8
require 'test_helper'

class TimezoneTest < ActiveSupport::TestCase
  setup do
    @instance = build(:user)
  end

  test 'обязательное поле' do
    instance.timezone = nil
    assert_not instance.valid?
  end

  test 'можно только поддерживаемые' do
    instance.timezone = 'aa'
    assert_not instance.valid?
  end
end
