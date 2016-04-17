# coding: utf-8
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
end

class ActionController::TestCase
  include ActiveJob::TestHelper
  include ActionMailer::TestHelper

  ## Залогиниться.
  def sign_in(account)
    session[:account_id] = account.id
  end

  ## Разлогиниться.
  def sign_out
    session[:account_id] = nil
  end
end

class ActionView::TestCase
  ## Тестирование хелперов (чтоб в них были доступны link_to и подобное).
  include Rails.application.routes.url_helpers

  def default_url_options
    ActionMailer::Base.default_url_options
  end
end

class ActionDispatch::IntegrationTest
  self.use_transactional_fixtures = false

  teardown do
    js_off
  end

  ## Залогиниться.
  def sign_in(account)
    page.set_rack_session(account_id: account.id)
  end

  ## Разлогиниться.
  def sign_out
    page.set_rack_session(account_id: nil)
  end
end
