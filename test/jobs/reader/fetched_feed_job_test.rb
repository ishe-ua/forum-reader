require 'test_helper'

module Reader
  class FetchedFeedJobTest < ActiveJob::TestCase
    setup do
      @job = FetchedFeedJob.new
    end

    test 'perform' do
      job.class.perform_now('http://example.com/feed', 'any stream')
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

    test 'parse_and_save_news => success' do
      fixture_name = %i(reddit_ruby opennet lbua atytarenko).sample
      VCR.use_cassette(fixture_name.to_s) do
        feed = feeds(fixture_name)
        feed.update(last_fetch_at: 200.years.ago)

        feed_stream = Faraday.get(feed.url).body
        assert job.send(:parse_and_save_news, feed, feed_stream).positive?
      end
    end

    test 'parse_and_save_news => fail' do
      assert_equal job.send(:parse_and_save_news, nil, 'left stream'), 0
    end
  end
end
