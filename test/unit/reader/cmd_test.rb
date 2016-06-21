require 'test_helper'

module Reader
  class CmdTest < ActiveSupport::TestCase
    setup do
      @instance = Class.new { include Cmd }.new
      @user = users(:ishe)
      @feed = feeds(:lbua)
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
      news = instance.find_news_in(@feed, 1.day.ago, Time.zone.now)
      assert_equal news.count, 1
    end

    test 'find_news_in => not found' do
      news = instance.find_news_in(@feed, 2.days.ago, 1.day.ago)
      assert_equal news.count, 0
    end
  end
end
