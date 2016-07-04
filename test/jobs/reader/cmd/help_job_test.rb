require 'test_helper'

module Reader
  module Cmd
    class HelpJobTest < ActiveJob::TestCase
      setup do
        @job = HelpJob.new
      end

      test 'regexp' do
        skip
      end
    end
  end
end
