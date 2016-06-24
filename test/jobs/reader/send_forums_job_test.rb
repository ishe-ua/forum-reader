require 'test_helper'

module Reader
  class SendForumsJobTest < ActiveJob::TestCase
    attr_reader :forum

    setup do
      @job = SendForumsJob.new
      @forum = forums(:reddit_ruby)
    end

    test 'perform' do
      skip
    end

    test 'perform => feed not found' do
      skip
    end

    test 'send to email' do
      forum.email! # FIX: assert_enqueued_emails
      assert_enqueued_jobs(1) { job.send(:send_to, forum, [FeedItem.first]) }
    end

    test 'send to jabber' do
      forum.jabber!
      assert_enqueued_jobs(1) { job.send(:send_to, forum, [FeedItem.first]) }
    end
  end
end
