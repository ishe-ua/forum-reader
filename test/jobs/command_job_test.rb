require 'test_helper'

class CommandJobTest < ActiveJob::TestCase
  setup do
    @instance = CommandJob.new
  end

  test 'find_user_from' do
    user = instance.send(:find_user_from, 'ishe@example.com/ipad')
    assert_equal user, users(:ishe)
  end

  test 'with_plus?' do
    assert instance.send(:with_plus?, 'bbc+')
    assert_not instance.send(:with_plus?, 'bbc')
  end
end
