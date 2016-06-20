require 'test_helper'

module Reader
  class CleanerJobTest < ActiveJob::TestCase
    setup do
      @job = CleanerJob.new
      @feed = create_feed
    end

    test 'find_feed_items_for_clean => found' do
      prepare_data
      rel = job.send(:find_feed_items_for_clean, @feed)
      assert rel.count > 0
    end

    test 'find_feed_items_for_clean => not found' do
      rel = job.send(:find_feed_items_for_clean, @feed)
      assert rel.count == 0
    end

    private

    def create_feed
      feed = build(:feed)
      feed.save!
      feed
    end

    def prepare_data
      time = CleanerJob::MIN_STORE_TIME + 1.day
      count = CleanerJob::MIN_STORE_ITEMS + 1

      travel_to(time.ago) do
        count.times do |i|
          fi = build(:feed_item, url: "http://example.com/#{i}")
          fi.feed_id = @feed.id
          fi.save
        end
      end
    end
  end
end
