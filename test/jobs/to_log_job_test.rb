require 'test_helper'

class ToLogJobTest < ActiveJob::TestCase
  setup do
    @job = ToLogJob.new
  end

  test 'perform' do
    assert_nothing_raised { job.class.perform_now('aa', 'info') }
  end

  test 'raise if log level is not String type' do
    assert_raises { job.class.perform_now('aa', :info) }
  end

  test 'raise if message is empty' do
    assert_raises { job.class.perform_now(nil, 'info') }
  end
end
