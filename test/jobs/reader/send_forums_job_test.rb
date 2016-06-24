require 'test_helper'

module Reader
  class SendForumsJobTest < ActiveJob::TestCase
    setup do
      @job = SendForumsJob.new
    end

    test 'perform' do
      skip
    end

    test 'perform => feed not found' do
      skip
    end

    test 'send to email' do
      skip
    end

    test 'send to jabber' do
      skip
    end
  end
end
