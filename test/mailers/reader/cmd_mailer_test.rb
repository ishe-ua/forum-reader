require 'test_helper'

module Reader
  class CmdMailerTest < ActionMailer::TestCase
    setup do
      @mailer = CmdMailer
      @user = users(:john)
      @account = @user.account
    end

    test 'help' do
      mail = mailer.help(@user)
      assert_equal mail.to, [@account.email]
    end

    test 'selection' do
      plus = [true, false].shuffle.sample
      mail = mailer.selection(@user, FeedItem.all, plus)

      assert_equal mail.to, [@user.jabber]
      assert_equal mail.body.encoded.include?(FeedItem.first.text), plus
    end
  end
end
