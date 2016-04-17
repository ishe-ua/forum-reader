require 'test_helper'

class AdminMailerTest < ActionMailer::TestCase
  setup do
    @mailer = AdminMailer
  end

  teardown do
    assert mail.subject.present?
    assert_equal [APP::ADMIN_EMAIL], mail.to
  end

  test 'new_registration' do
    @mail = mailer.new_registration(accounts(:mary))
  end

  test 'stats' do
    @mail = mailer.stats
  end
end
