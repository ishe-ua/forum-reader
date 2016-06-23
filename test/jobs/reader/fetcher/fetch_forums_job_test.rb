require 'test_helper'

module Reader
  module Fetcher
    class FetchForumsJobTest < ActiveJob::TestCase
      setup do
        @job = FetchForumsJob
      end

      test 'success' do
        travel_to(1.day.from_now) do
          assert_enqueued_jobs(Forum.count) { job.perform_now }
        end
      end
    end
  end
end
