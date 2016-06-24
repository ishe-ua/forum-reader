require 'test_helper'

class AdminMailerTest < ActionMailer::TestCase
  setup do
    @mailer = AdminMailer
  end

  test 'new_registration' do
    mail = mailer.new_registration(accounts(:mary))
    assert_equal [APP::ADMIN_EMAIL], mail.to
  end

  test 'stats' do
    mail = mailer.stats
    assert_equal [APP::ADMIN_EMAIL], mail.to
  end
end
