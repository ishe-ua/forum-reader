require 'test_helper'

module Reader
  class ReplyJobTest < ActiveJob::TestCase
    setup do
      clear_redis
      @job = ReplyJob
    end

    test 'put to redis' do
      job.perform_now('text', 'user@example.com')
      hash = JSON.parse(redis.rpop(BoteOut::REDIS_KEY), symbolize_names: true)

      assert_equal hash[:text], 'text'
      assert_equal hash[:to], 'user@example.com'
    end
  end
end
