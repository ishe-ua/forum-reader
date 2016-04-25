# coding: utf-8
require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test 'should get home' do
    get :home
    assert_response :success

    sign_in accounts(:ishe)

    get :home
    assert_redirected_to data_path, 'для залогиненных не показываем'
  end

  test 'should get help' do
    get :help
    assert_response :success
  end

  test 'should get info' do
    get :info, {}, {}, notice: 'success'
    assert_response :success

    get :info, {}, {}, alert: 'fail'
    assert_response :success
  end

  test 'info не показывается, если flash-ы пустые' do
    get :info
    assert_redirected_to root_path
  end

  test 'should get data' do
    get :data
    assert_redirected_to new_session_path, 'защищенная страница'

    sign_in accounts(:ishe)

    get :data
    assert_response :success
  end
end
