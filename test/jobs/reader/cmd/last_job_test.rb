require 'test_helper'

module Reader
  module Cmd
    class LastJobTest < ActiveJob::TestCase
      setup do
        @job = LastJob.new
        @from = users(:ishe).jabber
      end

      test 'fail => bad regexp' do
        assert_not job.perform('left cmd', @from)
      end
    end
  end
end
