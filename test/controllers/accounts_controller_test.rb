# coding: utf-8
require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  setup do
    @account = accounts(:john)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create account и отправить ему email-письма' do
    assert_enqueued_jobs 3 do
      assert_difference('Account.count') do
        post :create, account:
                        {
                          email: 'company@example.com',
                          password: APP::DEFAULT_PASSWORD,
                          password_confirmation: APP::DEFAULT_PASSWORD
                        }

        assert_response :redirect
        assert_redirected_to info_path
      end
    end
  end

  test 'should get edit' do
    sign_in @account
    get :edit, id: @account
    assert_response :success
  end

  test 'should update account' do
    acc_params = {
      email:                'company2@example.com',
      password:              APP::DEFAULT_PASSWORD,
      password_confirmation: APP::DEFAULT_PASSWORD
    }

    sign_in @account
    patch :update, id: @account, account: acc_params

    assert_response :redirect
    assert_redirected_to data_path
  end

  test 'изменили email - новый не подтвержденный, письмо для подтверждения' do
    sign_in @account

    assert_enqueued_jobs 1 do
      patch :update, id: @account, account: { email: 'new@example.com' }
      assert_not @account.reload.email_confirmed?
    end
  end

  test 'destroy account - deprecated operation' do
    sign_in @account
    assert_raise do
      delete :destroy, id: @account
    end
  end
end
