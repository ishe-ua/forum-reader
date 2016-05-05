require 'test_helper'

class ScheduleTest < ActiveSupport::TestCase
  setup do
    @instance = build(:letter)
  end

  test '#set_default_schedule' do
    assert instance.hour
    assert instance.minute
  end
end
