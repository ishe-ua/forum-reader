# coding: utf-8
require 'test_helper'

class LetterItemsControllerTest < ActionController::TestCase
  setup do
    @letter_item = letter_items(:atytarenko)
    @letter = @letter_item.letter
    @user = @letter.user

    sign_in(@user.account)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create letter_item' do
    assert_difference('LetterItem.count') do
      post :create, letter_item: {
        letter_id: @letter.id,
        name: 'example',
        url: 'example.com/rss'
      }

      assert_redirected_to data_path
    end
  end

  test 'should get edit' do
    get :edit, id: @letter_item
    assert_response :success
  end

  test 'should update letter_item' do
    params = { name: 'example', letter_id: @letter.id }
    patch :update, id: @letter_item, letter_item: params
    assert_redirected_to data_path
  end

  test 'should destroy letter_item' do
    assert_difference('LetterItem.count', -1) do
      delete :destroy, id: @letter_item, format: :js
    end
  end
end
