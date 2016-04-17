# coding: utf-8
require 'test_helper'

class ResetPasswordTest < ActionController::TestCase
  tests AccountsController

  test 'форма показывается' do
    get :reset_password
    assert_response :success
  end

  test 'success: пароль изменяется, письмо с ним высылается' do
    assert_enqueued_jobs 1 do
      hu = accounts(:john)
      password1 = hu.password_digest.dup

      post :reset_password, email: hu.email
      password2 = hu.reload.password_digest

      assert_response :redirect
      assert_not_empty flash.notice
      assert_redirected_to info_path

      assert_not_equal password1, password2, 'пароль изменился'
    end
  end

  test 'fail - такой email в базе отсутствует' do
    post :reset_password, email: 'left-email@example.com'
    assert_response :redirect

    assert_not_empty flash.alert
    assert_redirected_to info_path
  end
end
