require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @instance = build(:user)
  end

  include ValidateInstanceTest
  include ValidateFixturesTest
end
