require 'test_helper'

module Reader
  class FetchFeedJobTest < ActiveJob::TestCase
    setup do
      @job = FetchFeedJob.new
    end

    test 'perform' do
      VCR.use_cassette(:reddit_ruby) do
        url = feeds(:reddit_ruby).url
        assert job.class.perform_now(url)
      end
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

    test 'find_news => success' do
      fixture_name = %i[reddit_ruby opennet lbua atytarenko].sample
      VCR.use_cassette(fixture_name.to_s) do
        feed = feeds(fixture_name)
        feed.update!(last_fetch_at: 10.years.ago)

        assert job.send(:find_news, feed)
      end
    end

    test 'find_news => fail' do
      assert_raise { job.send(:find_news, nil) }
    end
  end
end
