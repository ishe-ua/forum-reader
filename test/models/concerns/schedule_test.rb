# coding: utf-8
require 'test_helper'

class ScheduleTest < ActiveSupport::TestCase
  setup do
    @instance = build(:letter)
  end

  test "дефолтное время выставляется" do
    assert instance.hour
    assert instance.minute
  end

  test '#hour_in_user_tz' do
    skip
    assert instance.respond_to?(:hour_in_user_tz)
  end
end
