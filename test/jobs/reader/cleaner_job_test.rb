require 'test_helper'

module Reader
  class CleanerJobTest < ActiveJob::TestCase
    setup do
      @job = CleanerJob.new
      @feed = build(:feed)
      @feed.save!
    end

    test 'find_feed_items_for_clean => found' do
      prepare_data(count: CleanerJob::MIN_STORE_ITEMS + 1)
      rel = job.send(:find_feed_items_for_clean, @feed)
      assert rel.count > 0
    end

    test 'find_feed_items_for_clean => not found' do
      prepare_data(count: CleanerJob::MIN_STORE_ITEMS - 1)
      rel = job.send(:find_feed_items_for_clean, @feed)
      assert rel.count < CleanerJob::MIN_STORE_ITEMS
    end

    private

    def prepare_data(opts = {})
      time = CleanerJob::MIN_STORE_TIME + 1.day
      travel_to(time.ago) do
        opts[:count].times do |i|
          fi = build(:feed_item, url: "http://example.com/#{i}")
          fi.feed_id = @feed.id
          fi.save
        end
      end
    end
  end
end
