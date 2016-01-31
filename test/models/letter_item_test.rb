require 'test_helper'

class LetterItemTest < ActiveSupport::TestCase
  setup do
    @instance = build(:letter_item)
  end

  include ValidateInstanceTest
  include ValidateFixturesTest
end
