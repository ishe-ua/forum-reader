require 'test_helper'

module Reader
  class CmdMailerTest < ActionMailer::TestCase
    setup do
      @mailer = CmdMailer
      @user = users(:john)
    end

    test 'help' do
      mail = mailer.help(@user)
      assert_equal mail.to, [@user.account.email]
    end

    test 'forum_news' do
      forum = Forum.first
      feed_item = FeedItem.first

      target = Target::SUPPORTED_TARGETS.shuffle.sample.to_sym
      mail = mailer.forum_news(forum, feed_item, target)

      assert_equal mail.to, [forum.user.jabber] if target == :jabber
      assert_equal mail.to, [forum.user.account.email] if target == :email
    end

    test 'letter_with_news' do
      mail = mailer.letter_with_news(letters(:ua), [])
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
