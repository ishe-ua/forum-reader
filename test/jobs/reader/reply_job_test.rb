require 'test_helper'

module Reader
  class ReplyJobTest < ActiveJob::TestCase
    setup do
      @job = ReplyJob
    end

    test 'exception if perform' do
      assert_raise { job.perform_now(nil, nil) }
    end
  end
end
