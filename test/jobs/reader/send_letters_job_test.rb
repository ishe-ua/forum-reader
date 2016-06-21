require 'test_helper'

module Reader
  class SendLettersJobTest < ActiveJob::TestCase
    setup do
      @job = SendLettersJob.new(nil)
    end

    test 'update_last_post_at' do
      stub(@job).time { 1.year.ago }
      letter = letters(:dev)

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
