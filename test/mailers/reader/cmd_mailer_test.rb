require 'test_helper'

module Reader
  class CmdMailerTest < ActionMailer::TestCase
    setup do
      @mailer = CmdMailer
      @account = accounts(:john)
    end

    test 'help' do
      mail = mailer.help(@account.user)
      assert_equal [@account.email], mail.to
    end

    test 'truth' do
      skip
    end
  end
end
