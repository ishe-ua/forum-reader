require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  setup do
    @instance = build(:message)
  end

  include ValidateInstanceTest
  include ValidateFixturesTest

  test 'from required' do
    instance.from = nil
    assert_not instance.valid?
  end
end
