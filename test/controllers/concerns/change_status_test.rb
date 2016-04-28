# coding: utf-8
require 'test_helper'

class ChangeStatusTest < ActionController::TestCase
  #tests [ReaderSetsController, MailerSetsController].shuffle.sample
  tests [ReaderSetsController].shuffle.sample

  setup do
    @account = accounts(:ishe)
    sign_in(@account)
  end

  test '#success' do
    patch :change_status, id: @account.user.reader_set
    assert_response :success
  end
end
