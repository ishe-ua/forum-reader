require 'test_helper'

class TimezoneTest < ActiveSupport::TestCase
  setup do
    @instance = build(:user)
  end

  test 'required' do
    instance.timezone = nil
    assert_not instance.valid?
  end

  test 'only supported values' do
    instance.timezone = 'left/timezone'
    assert_not instance.valid?
  end
end
