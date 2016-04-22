# coding: utf-8
require 'test_helper'

class CheckAccountTest < ActionController::TestCase
  tests PagesController

  test 'новеньких отправляем дозаполнять аккаунт' do
    account = build(:account)
    account.save!

    sign_in(account)

    get :data
    assert_redirected_to sets_path
  end

  test 'аккаунт заполнен - никого никуда не отправляем' do
    sign_in(accounts(:john))

    get :help
    assert_response :success
  end
end
