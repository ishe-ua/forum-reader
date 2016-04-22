# coding: utf-8
require 'test_helper'

class CheckAccountTest < ActionController::TestCase
  tests PagesController

  setup do
    sign_in(accounts(:john))
  end

  test 'аккаунт заполнен' do
    get :help
    assert_response :success
  end

  test 'перенаправляем на заполнение аккаунта' do
    accounts(:john).user.update_attribute(:jabber, nil)
    assert_not accounts(:john).user.valid?

    get :data

    assert_response :redirect
    assert_redirected_to sets_path
  end
end
