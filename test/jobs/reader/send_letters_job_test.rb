require 'test_helper'

module Reader
  class SendLettersJobTest < ActiveJob::TestCase
    setup do
      @job = SendLettersJob.new(nil)
    end

    test 'update_last_post_at' do
      stub(@job).time { 3.days.ago }

      letter = letters(:dev)
      pre = letter.last_post_at

      job.send(:update_last_post_at, letter)
      current = letter.reload.last_post_at

      assert_not_equal current, pre
    end
  end
end
