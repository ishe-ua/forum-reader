# coding: utf-8

require 'test_helper'

class AccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @account = accounts(:john)
  end

  test 'should get new' do
    get new_account_path
    assert_response :success
  end

  test 'should create account и отправить ему email-письма' do
    assert_enqueued_emails 3 do
      assert_difference('Account.count') do
        post accounts_path, params: {
          account:
            {
              email: 'company@example.com',
              password: APP::DEFAULT_PASSWORD,
              password_confirmation: APP::DEFAULT_PASSWORD
            }
        }

        assert_redirected_to info_path
      end
    end
  end

  test 'should get edit' do
    sign_in @account
    get edit_account_path(id: @account)
    assert_response :success
  end

  test 'should update account' do
    sign_in @account

    patch account_path(id: @account), params: {
      account: {
        email:                'company2@example.com',
        password:              APP::DEFAULT_PASSWORD,
        password_confirmation: APP::DEFAULT_PASSWORD
      }
    }

    assert_redirected_to data_path
  end

  test 'изменили email - новый не подтвержденный, письмо для подтверждения' do
    sign_in @account

    assert_enqueued_emails 1 do
      patch account_path(id: @account), params: {
        account: { email: 'new@example.com' }
      }
      assert_not @account.reload.email_confirmed?
    end
  end

  test 'destroy account - deprecated operation' do
    sign_in @account
    assert_raise do
      delete accounts_path(id: @account)
    end
  end
end
