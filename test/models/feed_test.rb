require 'test_helper'

class FeedTest < ActiveSupport::TestCase
  setup do
    @instance = build(:feed)
  end

  include ValidateInstanceTest
  include ValidateFixturesTest

  test 'uniqueness url' do
    instance.url = feeds(:opennet).url
    assert_not instance.valid?
  end
end
