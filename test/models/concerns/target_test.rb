require 'test_helper'

class TargetTest < ActiveSupport::TestCase
  setup do
    @instance = build(:forum)
  end

  test 'required field' do
    instance.target = nil
    assert_not instance.valid?
  end

  test 'left values is deprecated' do
    assert_raise { instance.target = 1_000_000 }
  end
end
