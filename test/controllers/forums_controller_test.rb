# coding: utf-8
require 'test_helper'

class ForumsControllerTest < ActionController::TestCase
  setup do
    @user = users(:ishe)
    @forum = @user.forums.first

    sign_in(@user.account)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create forum' do
    assert_difference('Forum.count') do
      post :create, forum: {
        user_id: @user.id,
        name: 'example',
        url: 'example.com/feed'
      }

      assert_redirected_to data_path
    end
  end

  test 'should get edit' do
    get :edit, id: @forum
    assert_response :success
  end

  test 'should update forum' do
    params = {
      name: 'example',
      url: 'example.com/feed/17'
    }

    patch :update, id: @forum, forum: params
    assert_redirected_to data_path
  end

  test 'should destroy forum' do
    assert_difference('Forum.count', -1) do
      delete :destroy, id: @forum, format: :js
    end
  end
end
