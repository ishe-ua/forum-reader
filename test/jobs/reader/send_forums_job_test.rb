require 'test_helper'

module Reader
  class SendForumsJobTest < ActiveJob::TestCase
    attr_reader :forum, :feed

    setup do
      @job = SendForumsJob.new
      @forum = forums(:reddit_ruby)
      @feed = feeds(:reddit_ruby)
    end

    test 'perform' do
      skip
    end

    test 'perform => feed not found' do
      skip
    end

    test 'find_unsended_news => found' do
      FeedItem.update_all(created_at: 1.year.since)
      assert_not_empty job.send(:find_unsended_news, forum, feed)
    end

    test 'find_unsended_news => not found' do
      FeedItem.update_all(created_at: 1.year.ago)
      assert_empty job.send(:find_unsended_news, forum, feed)
    end

    test 'send to email' do
      forum.email! # FIX: replace to assert_enqueued_emails
      assert_enqueued_jobs(1) { job.send(:send_to, forum, [FeedItem.first]) }
    end

    test 'send to jabber' do
      forum.jabber!
      assert_enqueued_jobs(1) { job.send(:send_to, forum, [FeedItem.first]) }
    end
  end
end
