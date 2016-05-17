require 'test_helper'

class LastFetchAtTest < ActiveSupport::TestCase
  setup do
    @instance = feeds(:lbua)
  end

  test '#time_to_fetch? => true' do
    assert instance_class.time_to_fetch?('http://example.com/left-feed'),
           'feed not found'

    instance.update!(last_fetch_at: nil)

    assert instance_class.time_to_fetch?(instance.url),
           'last_fetch_at is empty'

    travel_to(1.day.from_now) do
      assert instance_class.time_to_fetch?(instance.url),
             'time to fetch'
    end
  end

  test '#time_to_fetch? => false' do
    assert_not instance_class.time_to_fetch?(instance.url),
               'time to fetch'
  end
end
