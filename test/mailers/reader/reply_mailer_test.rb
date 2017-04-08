require 'test_helper'

module Reader
  class ReplyMailerTest < ActionMailer::TestCase
    setup do
      @mailer = ReplyMailer
      @user = users(:john)
    end

    test 'help' do
      mail = mailer.help(@user)
      assert_equal mail.to, [@user.account.email]
    end

    test 'forum_news' do
      forum = Forum.all.shuffle.sample
      feed_item = FeedItem.first

      mail = mailer.forum_news(forum, feed_item)

      if forum.email?
        assert_equal mail.to, [forum.user.account.email]
      else
        assert_equal mail.to, [forum.user.jabber]
      end
    end

    test 'letter_with_news' do
      news = [letter_item: LetterItem.first, feed_items: FeedItem.all]
      mail = mailer.letter_with_news(letters(:ua), news)
      assert_not_empty mail.body.encoded, 'regards present'
    end

    test 'selection' do
      plus = [true, false].shuffle.sample
      mail = mailer.selection(@user, FeedItem.all, plus)

      assert_equal mail.to, [@user.jabber]
      assert_equal mail.body.encoded.include?(FeedItem.first.text), plus
    end
  end
end
