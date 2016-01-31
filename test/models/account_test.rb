require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  setup do
    @instance = build(:account)
  end

  include ValidateInstanceTest
  include ValidateFixturesTest
end
