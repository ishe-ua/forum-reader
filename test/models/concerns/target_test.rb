# coding: utf-8
require 'test_helper'

class TargetTest < ActiveSupport::TestCase
  setup do
    @instance = build(:forum)
  end

  test 'обязательное поле' do
    instance.target = nil
    assert_not instance.valid?
  end

  test 'левое значение не прокатит' do
    assert_raise { instance.target = 1_000_000 }
  end
end
