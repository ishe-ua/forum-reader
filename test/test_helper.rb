ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

Dir[
  Rails.root.join('test/support/**/*.rb'),
  Rails.root.join('test/**/shared/**/*.rb')

].each { |f| require f }

###
#
#

class ActiveSupport::TestCase
  fixtures :all
  attr_reader :instance
end

class ActionController::TestCase
  include ActiveJob::TestHelper
  include ActionMailer::TestHelper

  def sign_in(account)
    session[:account_id] = account.id
  end

  def sign_out
    session[:account_id] = nil
  end
end

class ActionView::TestCase
  ## For access to link_to and others in helper tests
  include Rails.application.routes.url_helpers

  def default_url_options
    ActionMailer::Base.default_url_options
  end
end

class ActionDispatch::IntegrationTest
  self.use_transactional_fixtures = false

  setup { js }
  teardown { js_off }

  def sign_in(account)
    page.set_rack_session(account_id: account.id)
  end

  def sign_out
    page.set_rack_session(account_id: nil)
  end
end
