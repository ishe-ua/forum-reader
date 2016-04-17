# coding: utf-8
require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  setup do
    @account = accounts(:john)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should post create - success' do
    get :create, email: @account.email.upcase, password: APP::DEFAULT_PASSWORD
    assert_equal session[:account_id], @account.id

    assert_response :redirect
    assert_redirected_to root_path
  end

  test 'should post create - fail' do
    get :create, email: 'left-email@example.com', password: 'left password'
    assert_response :success, 'остались на той же странице'

    assert_not session[:account_id]
    assert_equal flash[:alert], I18n.t('auth.sign_in.fail')
  end

  test 'заблокированные не залогинятся' do
    @account.lock!

    get :create, email: @account.email, password: APP::DEFAULT_PASSWORD
    assert_response :success, 'остались на той же странице'

    assert_not session[:account_id]
    assert_equal flash[:alert], I18n.t('auth.sign_in.locked')
  end

  test 'should get destroy' do
    delete :destroy,
           { id:         @account.id },
           account_id: @account.id

    assert_response :redirect
    assert_redirected_to root_path

    assert_not session[:account_id]
  end
end
