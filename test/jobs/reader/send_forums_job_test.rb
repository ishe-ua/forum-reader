require 'test_helper'

module Reader
  class SendForumsJobTest < ActiveJob::TestCase
    attr_reader :forum

    setup do
      @job = SendForumsJob.new
      @forum = forums(:reddit_ruby)
    end

    test 'return news count if news exists' do
      feed = feeds(:reddit_ruby)
      forums(:reddit_ruby).update(last_post_at: 200.years.ago)

      news_count = job.class.perform_now(feed.url)
      assert news_count.positive?
    end

    test 'return nil if any news' do
      feed = feeds(:reddit_ruby)
      forums(:reddit_ruby).update(last_post_at: Time.zone.now)

      news_count = job.class.perform_now(feed.url)
      assert_not news_count
    end

    test 'find_unsended_news_in => found' do
      FeedItem.update_all(created_at: 1.year.since)
      assert_not_empty job.send(:find_unsended_news_in, forum)
    end

    test 'find_unsended_news_in => not found' do
      FeedItem.update_all(created_at: 1.year.ago)
      assert_empty job.send(:find_unsended_news_in, forum)
    end

    test 'send to email' do
      forum.email! # FIX: replace to assert_enqueued_emails
      assert_enqueued_jobs(1) do
        job.send(:send_to_target, forum, [FeedItem.first])
      end
    end

    test 'send to jabber' do
      forum.jabber!
      assert_enqueued_jobs(1) do
        job.send(:send_to_target, forum, [FeedItem.first])
      end
    end
  end
end
