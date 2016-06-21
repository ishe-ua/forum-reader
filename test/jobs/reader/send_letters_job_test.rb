require 'test_helper'

module Reader
  class SendLettersJobTest < ActiveJob::TestCase
    attr_reader :letter, :letter_item, :test_time

    setup do
      @letter = letters(:dev)
      @letter_item = letter_items(:opennet)

      @test_time = Time.utc(2016, 06, 18, letter.hour, letter.minute)
      @job = SendLettersJob.new(test_time)
    end

    test 'news_in (letter) => true' do
      stub(job).time { Time.zone.now }
      letter_item.update!(last_post_at: 1_000_000.days.ago)

      news = job.send(:news_in, letter)
      assert_not_empty news
    end

    test 'news_in (letter) => false' do
      stub(job).time { Time.zone.now }
      assert_empty job.send(:news_in, letter)
    end

    test 'news_in_the (letter_item) => true' do
      stub(job).time { Time.zone.now }
      letter_item.update!(last_post_at: 1_000_000.days.ago)

      news = job.send(:news_in_the, letter_item)
      assert_not_empty news
    end

    test 'news_in_the (letter_item) => false' do
      stub(job).time { Time.zone.now }
      assert_empty job.send(:news_in_the, letter_item)
    end

    test 'update_last_post_at' do
      stub(job).time { 1.year.ago }

      pre1 = letter.last_post_at
      pre2 = letter.letter_items.first.last_post_at

      job.send(:update_last_post_at, letter)

      cur1 = letter.reload.last_post_at
      cur2 = letter.letter_items.first.reload.last_post_at

      assert_not_equal cur1, pre1, 'changed for letter'
      assert_not_equal cur2, pre2, 'changed for letter_item'
    end
  end
end
