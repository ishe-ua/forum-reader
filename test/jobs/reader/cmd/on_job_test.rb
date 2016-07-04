require 'test_helper'

module Reader
  module Cmd
    class OnJobTest < ActiveJob::TestCase
      setup do
        @job = OnJob.new
      end

      test 'success' do
        assert_enqueued_jobs(1) { job.perform('on', users(:mary).jabber) }
      end

      test 'fail => user not found' do
        assert_no_enqueued_jobs { job.perform('oN', 'left@example.com') }
      end

      test 'fail => bad regexp' do
        assert_no_enqueued_jobs { job.perform('left', users(:mary).jabber) }
      end
    end
  end
end
