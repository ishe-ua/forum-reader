require 'test_helper'

module Reader
  module Fetcher
    class FetchLettersJobTest < ActiveJob::TestCase
      setup do
        @job = FetchLettersJob
      end

      test 'success' do
        travel_to(1.day.from_now) do
          assert_enqueued_jobs(LetterItem.count) { job.perform_now }
        end
      end
    end
  end
end
