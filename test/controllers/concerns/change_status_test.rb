# coding: utf-8
require 'test_helper'

class ChangeStatusTest < ActionController::TestCase
  tests [ReaderSetsController, MailerSetsController].shuffle.sample

  setup do
    @account = accounts(:ishe)
    sign_in(@account)
  end

  test '#success' do
    resource = @account.user.send(@controller.send(:resource_name).to_sym)
    patch :change_status, id: resource, format: :js
    assert_response :success
  end
end
