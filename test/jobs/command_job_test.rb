require 'test_helper'

class CommandJobTest < ActiveJob::TestCase
  setup do
    @job = CommandJob.new
  end

  test 'find_user_from' do
    user = job.send(:find_user_from, 'ishe@example.com/ipad')
    assert_equal user, users(:ishe)
  end

  test 'find_name_from' do
    assert_equal job.send(:find_name_from, 'bbc'), 'bbc'
    assert_equal job.send(:find_name_from, 'bbc+'), 'bbc'
    assert_equal job.send(:find_name_from, ['', nil].shuffle.sample), ''
  end

  test 'find_count_from' do
    assert_equal job.send(:find_count_from, '15'), 15
    assert_equal job.send(:find_count_from, 10_000),
                 CommandJob::MAX_SELECTION_SIZE
    assert_equal job.send(:find_count_from, ['', nil].shuffle.sample),
                 CommandJob::DEFAULT_SELECTION_SIZE
  end

  test 'with_plus?' do
    assert job.send(:with_plus?, 'bbc+')
    assert_not job.send(:with_plus?, 'bbc')
    assert_not job.send(:with_plus?, ['', nil].shuffle.sample)
  end
end
