require 'test_helper'

module Reader
  class SendForumsJobTest < ActiveJob::TestCase
    setup do
      @job = SendForumsJob
    end

    test 'the truth' do
      skip
    end
  end
end
