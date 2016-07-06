require 'test_helper'

module Reader
  module Cmd
    class LastJobTest < ActiveJob::TestCase
      setup do
        @job = LastJob.new
        @from = users(:ishe).jabber

        @test_objects = %w(
          reddit_ruby
          dev
          opennet
        ) # forum, letter, letter_item
      end

      test 'success' do
        @test_objects.each do |obj_type|
          text = job.perform("last #{obj_type}", @from)
          assert text

          assert_not_equal text, CommandJob::EMPTY
          assert_not_equal text, CommandJob::NOT_FOUND
        end
      end

      test 'empty' do
        FeedItem.destroy_all
        @test_objects.each do |obj_type|
          text = job.perform("last #{obj_type}", @from)
          assert_equal text, CommandJob::EMPTY
        end
      end

      test 'not found' do
        text = job.perform('last aaa', @from)
        assert_equal text, CommandJob::NOT_FOUND
      end

      test 'bad regexp' do
        assert_not job.perform('left cmd', @from)
      end
    end
  end
end
