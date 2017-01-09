require 'test_helper'

class CheckAccountTest < ActionDispatch::IntegrationTest
  test 'send new users to afterfilling account' do
    account = build(:account)
    account.save!

    sign_in(account)

    get data_path
    assert_redirected_to edit_account_path(account)
  end

  test 'do not send anybody to afterfilling if all data have filled' do
    sign_in(accounts(:john))
    get help_path
    assert_response :success
  end
end
