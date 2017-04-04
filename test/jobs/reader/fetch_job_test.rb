require 'test_helper'

module Reader
  class FetchJobTest < ActiveJob::TestCase
    setup do
      @job = FetchJob
    end

    test 'success' do
      travel_to(1.day.from_now) do
        urls_for_fetch_count = Forum.count + LetterItem.count
        assert_enqueued_jobs(urls_for_fetch_count) { job.perform_now }
      end
    end
  end
end
