require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get home' do
    get home_path
    assert_response :success

    sign_in accounts(:ishe)

    get home_path
    assert_redirected_to data_path
  end

  test 'should get help' do
    get help_path
    assert_response :success
  end

  test 'should get info' do
    get info_path
    assert_redirected_to root_path, 'empty message'
  end

  test 'should get data' do
    get data_path
    assert_redirected_to new_session_path, 'protected page'

    sign_in accounts(:ishe)

    get data_path
    assert_response :success
  end
end
