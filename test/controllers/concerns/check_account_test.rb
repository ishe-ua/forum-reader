require 'test_helper'

class CheckAccountTest < ActionController::TestCase
  tests PagesController

  test 'send new users to afterfilling account' do
    account = build(:account)
    account.save!

    sign_in(account)

    get :data
    assert_redirected_to edit_account_path(account)
  end

  test 'do not send anybody to afterfilling if all data have filled' do
    sign_in(accounts(:john))

    get :help
    assert_response :success
  end
end
