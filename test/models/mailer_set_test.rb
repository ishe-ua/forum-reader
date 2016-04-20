require 'test_helper'

class MailerSetTest < ActiveSupport::TestCase
  setup do
    @instance = mailer_sets(:mary)
  end

  include ValidateInstanceTest
  include ValidateFixturesTest
end
