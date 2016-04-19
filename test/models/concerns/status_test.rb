# coding: utf-8
require 'test_helper'

class StatusTest < ActiveSupport::TestCase
  setup do
    @instance = build(:reader_conf)
  end

  test 'обязательное поле' do
    instance.status = nil
    assert_not instance.valid?
  end

  test 'левое значение не прокатит' do
    assert_raise { instance.status = 1_000_000 }
  end
end
