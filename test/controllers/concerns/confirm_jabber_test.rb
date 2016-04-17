# coding: utf-8
require 'test_helper'

class ConfirmJabberTest < ActionController::TestCase
  tests AccountsController

  setup do
    @user = users(:john)
    @user.unconfirm_jabber
    assert_not @user.reload.jabber_confirmed?
  end

  test 'success' do
    get :confirm_jabber, token: @user.jabber_confirmation_token

    assert_response :redirect
    assert_redirected_to info_path

    assert_not_nil @user.reload.jabber_confirmation_at
    assert_not_empty flash.notice
  end

  test 'fail if left token' do
    get :confirm_jabber, token: 'left-token'

    assert_response :redirect
    assert_redirected_to info_path

    assert_nil @user.reload.jabber_confirmation_at
    assert_not_empty flash.alert
  end

  test 'при success также выполняется auto_sign_in' do
    get :confirm_jabber, token: @user.jabber_confirmation_token

    assert @controller.send(:signed_in?)
    assert_not_empty flash.notice
  end
end
