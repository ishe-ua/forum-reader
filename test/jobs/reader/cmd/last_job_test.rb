require 'test_helper'

module Reader
  module Cmd
    class LastJobTest < ActiveJob::TestCase
      setup do
        @job = LastJob.new
        @from = users(:ishe).jabber
      end

      test 'success' do
        %w(
          reddit_ruby
          dev
          opennet
        ).each do |obj_type| # forum, letter, letter_item
          text = job.perform("last #{obj_type}", @from)
          assert text

          assert_not_equal text, CommandJob::EMPTY
          assert_not_equal text, CommandJob::NOT_FOUND
        end
      end

      test 'fail => bad regexp' do
        assert_not job.perform('left cmd', @from)
      end
    end
  end
end
