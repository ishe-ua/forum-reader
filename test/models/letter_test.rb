require 'test_helper'

class LetterTest < ActiveSupport::TestCase
  setup do
    @instance = build(:letter)
  end

  include ValidateInstanceTest
  include ValidateFixturesTest
end
