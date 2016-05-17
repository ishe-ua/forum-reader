require 'test_helper'

class LastFetchAtTest < ActiveSupport::TestCase
  setup do
    @instance = build(:feed)
  end

  test 'can be empty' do
    instance.last_fetch_at = nil
    assert instance.valid?
  end

  test '#time_to_fetch? => true' do
    assert instance_class.time_to_fetch?('http://example.com/left-feed'),
           'feed not found'

    feed = feeds(:lbua)
    feed.update!(last_fetch_at: nil)

    assert instance_class.time_to_fetch?(feed.url),
           'last_fetch_at is empty'

    travel_to(1.day.from_now) do
      assert instance_class.time_to_fetch?(feed.url),
             'time to fetch'
    end
  end

  test '#time_to_fetch? => false' do
    feed = feeds(:lbua)
    assert_not instance_class.time_to_fetch?(feed.url),
               'time to fetch'
  end
end
