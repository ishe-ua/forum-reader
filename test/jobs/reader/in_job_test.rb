require 'test_helper'

module Reader
  class InJobTest < ActiveJob::TestCase
    setup do
      @job = InJob.new
    end

    test 'success' do
      assert_equal :help, job.class.perform_now('help', 'user@example.com')
      assert_equal :last, job.class.perform_now('last bbc', 'user@example.com')
      assert_equal :list, job.class.perform_now('list', 'user@example.com')
    end
  end
end
