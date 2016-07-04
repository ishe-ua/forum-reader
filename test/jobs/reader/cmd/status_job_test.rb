require 'test_helper'

module Reader
  module Cmd
    class StatusJobTest < ActiveJob::TestCase
      setup do
        @job = StatusJob.new
      end

      test 'success' do
        assert_enqueued_jobs(1) { job.perform('status', users(:mary).jabber) }
      end

      test 'fail => user not found' do
        assert_no_enqueued_jobs { job.perform('sTatus', 'left@example.com') }
      end

      test 'fail => regexp not found' do
        assert_no_enqueued_jobs { job.perform('left', users(:mary).jabber) }
      end
    end
  end
end
