# coding: utf-8
require 'test_helper'

class LettersControllerTest < ActionController::TestCase
  setup do
    @user = users(:ishe)
    @letter = @user.letters.first

    sign_in(@user.account)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create letter' do
    assert_difference('Letter.count') do
      post :create, letter: {
        user_id: @user.id,
        name: 'example'
      }

      assert_redirected_to data_path
    end
  end

  test 'should get edit' do
    get :edit, id: @letter
    assert_response :success
  end

  test 'should update letter' do
    params = { name: 'example' }
    patch :update, id: @letter, letter: params
    assert_redirected_to data_path
  end

  test 'should destroy letter' do
    assert_difference('Letter.count', -1) do
      delete :destroy, id: @letter, format: :js
    end
  end
end
