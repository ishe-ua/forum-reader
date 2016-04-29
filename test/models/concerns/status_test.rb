# coding: utf-8
require 'test_helper'

class StatusTest < ActiveSupport::TestCase
  setup do
    @instance = [reader_sets(:ishe), mailer_sets(:ishe)].shuffle.sample
  end

  test 'обязательное поле' do
    instance.status = nil
    assert_not instance.valid?
  end

  test 'левое значение не прокатит' do
    assert_raise { instance.status = 1_000_000 }
  end

  test '#change_status' do
    assert_equal instance.status, instance_class::ON
    assert instance.change_status
    assert_equal instance.status, instance_class::OFF
  end
end
