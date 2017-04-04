require 'test_helper'

class LastPostAtTest < ActiveSupport::TestCase
  setup do
    @instance = build(%i[forum letter letter_item].shuffle.sample)
  end

  test 'can be empty' do
    instance.last_post_at = nil
    assert instance.valid?
  end
end
