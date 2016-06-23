require 'test_helper'

module Reader
  module Fetcher
    class FetchFeedJobTest < ActiveJob::TestCase
      setup do
        @job = FetchFeedJob
      end

      test 'exception if perform' do
        assert_raise { job.perform_now(nil, nil) }
      end
    end
  end
end
