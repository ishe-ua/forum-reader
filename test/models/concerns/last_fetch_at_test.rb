require 'test_helper'

class LastFetchAtTest < ActiveSupport::TestCase
  setup do
    @instance = build(:feed)
  end

  test 'can be empty' do
    instance.last_fetch_at = nil
    assert instance.valid?
  end
end
