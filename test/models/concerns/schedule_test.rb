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
end
