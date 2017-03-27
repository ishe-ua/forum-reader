# coding: utf-8

require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @account = accounts(:john)
  end

  test 'should get new' do
    get new_session_path
    assert_response :success
  end

  test 'should post create - success' do
    post sessions_path(email: @account.email.upcase,
                       password: APP::DEFAULT_PASSWORD)

    assert_equal session[:account_id], @account.id
    assert_redirected_to root_path
  end

  test 'should post create - fail' do
    post sessions_path(email: 'left-email@example.com',
                       password: 'left password')
    assert_response :success, 'остались на той же странице'

    assert_not session[:account_id]
    assert_equal flash[:alert], I18n.t('sessions.errors.fail')
  end

  test 'заблокированные не залогинятся' do
    return unless defined?(Lock)
    @account.lock!

    post sessions_path(email: @account.email, password: APP::DEFAULT_PASSWORD)
    assert_response :success, 'остались на той же странице'

    assert_not session[:account_id]
    assert_equal flash[:alert], I18n.t('auth.sign_in.locked')
  end

  test 'should get destroy' do
    sign_in(@account)
    delete session_path(id: @account.id)

    assert_not session[:account_id]
    assert_redirected_to root_path
  end
end
