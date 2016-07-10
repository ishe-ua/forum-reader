require 'test_helper'

module Mailer
  class CleanerJobTest < ActiveJob::TestCase
    setup do
      @job = CleanerJob.new
      @user = users(:ishe)
    end

    test 'find_messages_for_clean => found' do
      count = CleanerJob::MIN_STORE_ITEMS + 1
      assert_with(count)
    end

    test 'find_messages_for_clean => not found' do
      count = CleanerJob::MIN_STORE_ITEMS - 1
      assert_with(count)
    end

    private

    def assert_with(count)
      prepare_data(count)
      sel = job.send(:find_messages_for_clean, @user)
      assert_equal sel.count, count
    end

    def prepare_data(count)
      Message.delete_all
      time = CleanerJob::MIN_STORE_TIME + 1.day
      travel_to(time.ago) do
        count.times do
          msg = build(:message)
          msg.user_id = @user.id
          msg.save!(validate: false)
        end
      end
    end
  end
end
