require 'test_helper'

module Reader
  module Cmd
    class ListJobTest < ActiveJob::TestCase
      setup do
        @job = ListJob.new
        @from = users(:ishe).jabber

        @test_objects = %w(
          reddit_ruby
          dev
          opennet
        ) # forum, letter, letter_item
      end

      test 'bad regexp' do
        assert_not job.perform('left cmd', @from)
      end
    end
  end
end
