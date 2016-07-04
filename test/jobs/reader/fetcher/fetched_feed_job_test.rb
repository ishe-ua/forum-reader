require 'test_helper'

module Reader
  module Fetcher
    class FetchedFeedJobTest < ActiveJob::TestCase
      setup do
        @job = FetchedFeedJob.new
      end

      test 'find_or_create_feed_by => finded' do
        assert_no_difference 'Feed.count' do
          url = feeds(:reddit_ruby).url
          job.send(:find_or_create_feed_by, url)
        end
      end

      test 'find_or_create_feed_by => created' do
        assert_difference 'Feed.count' do
          url = 'http://example.com/feed'
          job.send(:find_or_create_feed_by, url)
        end
      end

      # focus
      test 'parse_and_save_news' do
        feed = feeds(:opennet)
        feed_stream = VCR.use_cassette('opennet') do
          Net::HTTP.get_response(URI(feed.url))
        end

        assert feed_stream

        # assert_difference 'FeedItem.count' do
        #   count = job.send(:parse_and_save_news, feed, feed_stream)
        #   assert count > 0
        # end
      end
    end
  end
end
