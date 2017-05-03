require 'test_helper'

module Reader
  module Cmd
    class OnJobTest < ActiveJob::TestCase
      setup do
        @job = OnJob
      end

      test 'send news' do
        users(:ishe).forums
                    .each { |forum| forum.update(last_post_at: 200.years.ago) }

        sended_news = job.perform_now('on', users(:ishe).jabber)
        assert sended_news.positive?
      end

      test 'send done' do
        assert_not job.perform_now('on', users(:ishe).jabber).is_a?(Integer)
      end

      test 'fail => user not found' do
        assert_no_enqueued_jobs { job.perform_now('oN', 'left@example.com') }
      end

      test 'fail => bad regexp' do
        assert_no_enqueued_jobs { job.perform_now('left', users(:mary).jabber) }
      end
    end
  end
end
