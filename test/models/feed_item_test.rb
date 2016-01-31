require 'test_helper'

class FeedItemTest < ActiveSupport::TestCase
  setup do
    @instance = build(:feed_item)
  end

  include ValidateInstanceTest
  include ValidateFixturesTest
end
