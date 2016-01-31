require 'test_helper'

class FeedTest < ActiveSupport::TestCase
  setup do
    @instance = build(:feed)
  end

  include ValidateInstanceTest
  include ValidateFixturesTest
end
