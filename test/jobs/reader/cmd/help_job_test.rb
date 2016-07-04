require 'test_helper'

module Reader
  module Cmd
    class HelpJobTest < ActiveJob::TestCase
      setup do
        @job = HelpJob.new
      end

      test 'success' do
        assert_enqueued_jobs(1) { job.perform('help', users(:mary).jabber) }
      end

      test 'fail => user not found' do
        assert_no_enqueued_jobs { job.perform('help', 'left@example.com') }
      end

      test 'fail => regexp not found' do
        assert_no_enqueued_jobs { job.perform('left', users(:mary).jabber) }
      end
    end
  end
end
