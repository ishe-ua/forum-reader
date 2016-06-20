require 'test_helper'

module Reader
  class CmdTest < ActiveSupport::TestCase
    setup do
      @instance = Class.new { include Cmd }.new
      @user = users(:ishe)
    end

    test 'find_in_forums' do
      forum = instance.find_obj_by(@user, '/ruby')
      assert_equal forum, forums(:reddit_ruby)
    end

    test 'find_in_letters' do
      letter = instance.find_obj_by(@user, 'dev')
      assert_equal letter, letters(:dev)
    end

    test 'find_in_letter_items' do
      letter_item = instance.find_obj_by(@user, 'openNet')
      assert_equal letter_item, letter_items(:opennet)
    end

    test 'find_obj_by => not found' do
      assert_not instance.find_obj_by(@user, '/left_token')
    end

    test 'find_news_in => found' do
      skip
    end

    test 'find_news_in => not found' do
      skip
    end
  end
end
