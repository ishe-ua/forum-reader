require 'test_helper'

class ForumTest < ActiveSupport::TestCase
  setup do
    @instance = build(:forum)
  end

  include ValidateInstanceTest
  include ValidateFixturesTest
end
