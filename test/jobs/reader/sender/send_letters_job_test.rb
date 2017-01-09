require 'test_helper'

module Reader
  module Sender
    class SendLettersJobTest < ActiveJob::TestCase
      attr_reader :letter, :letter_item, :test_time

      setup do
        @job = SendLettersJob.new

        @letter = letters(:dev)
        @letter_item = letter_items(:opennet)

        @test_time = Time.use_zone(letter.user.timezone) do
          Time.zone.parse("18-6-2016 #{letter.hour}:#{letter.minute}")
        end
      end

      test 'perform' do
        assert_enqueued_jobs(2) { job.class.perform_now(test_time.to_s) }
        assert_no_enqueued_jobs { job.class.perform_now(Time.zone.now.to_s) }
      end

      test 'find_letters_for_send' do
        job.stub(:time, Time.zone.now) do
          assert_empty job.send(:find_letters_for_send)
        end

        job.stub(:time, -> { test_time }) do
          assert_not_empty job.send(:find_letters_for_send)
        end
      end

      test 'news_in => true' do
        job.stub(:time, Time.zone.now) do
          letter_item.update!(last_post_at: 1_000_000.days.ago)
          news = job.send(:news_in, letter)
          assert_not_empty news
        end
      end

      test 'news_in => false' do
        FeedItem.delete_all
        job.stub(:time, Time.zone.now) do
          assert_empty job.send(:news_in, letter)
        end
      end

      test 'news_in_the => true' do
        job.stub(:time, Time.zone.now) do
          letter_item.update!(last_post_at: 1_000_000.days.ago)
          news = job.send(:news_in_the, letter_item)
          assert_not_empty news
        end
      end

      test 'news_in_the => false' do
        FeedItem.delete_all
        job.stub(:time, Time.zone.now) do
          assert_empty job.send(:news_in_the, letter_item)
        end
      end

      test 'update_last_post_at' do
        job.stub(:time, 1.year.ago) do
          pre1 = letter.last_post_at
          pre2 = letter.letter_items.first.last_post_at

          job.send(:update_last_post_at, letter)

          cur1 = letter.reload.last_post_at
          cur2 = letter.letter_items.first.reload.last_post_at

          assert_not_equal cur1, pre1, 'changed for letter'
          assert_not_equal cur2, pre2, 'changed for letter_item'
        end
      end

      test 'send_time? => true' do
        job.stub(:time, -> { test_time }) do
          travel_to(test_time) { assert job.send(:send_time?, letter) }
        end
      end

      test 'send_time? => false' do
        job.stub(:time, Time.zone.now) do
          travel_to(Time.zone.now) { assert_not job.send(:send_time?, letter) }
        end
      end
    end
  end
end
