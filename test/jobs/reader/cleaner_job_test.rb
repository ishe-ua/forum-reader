require 'test_helper'

module Reader
  class CleanerJobTest < ActiveJob::TestCase
    setup do
      @job = CleanerJob.new
      @feed = build(:feed)
      @feed.save!
    end

    test 'find_feed_items_for_clean => found' do
      count = CleanerJob::MIN_STORE_ITEMS + 1
      assert_with(count)
    end

    test 'find_feed_items_for_clean => not found' do
      count = CleanerJob::MIN_STORE_ITEMS - 1
      assert_with(count)
    end

    private

    def assert_with(count)
      prepare_data(count)
      sel = job.send(:find_feed_items_for_clean, @feed)
      assert_equal sel.count, count
    end

    def prepare_data(count)
      time = CleanerJob::MIN_STORE_TIME + 1.day
      travel_to(time.ago) do
        count.times do |i|
          fi = build(:feed_item, url: "http://example.com/#{i}")
          fi.feed_id = @feed.id
          fi.save!(validate: false)
        end
      end
    end
  end
end
