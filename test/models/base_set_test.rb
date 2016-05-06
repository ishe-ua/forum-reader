require 'test_helper'

class BaseSetTest < ActiveSupport::TestCase
  setup do
    @instance = reader_sets(:mary)
  end

  test 'user_id required' do
    instance.user_id = nil
    assert_not instance.valid?
  end

  test 'user_id uniqueness' do
    dup = instance_class.new(instance.attributes)
    assert_not dup.valid?
  end
end
