require 'test_helper'

class LettersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:ishe)
    @letter = @user.letters.first

    sign_in(@user.account)
  end

  test 'should get new' do
    get new_letter_path
    assert_response :success
  end

  test 'should create letter' do
    assert_difference('Letter.count') do
      post letters_path, params: {
        letter: {
          user_id: @user.id,
          name: 'example'
        }
      }

      assert_redirected_to data_path
    end
  end

  test 'should get edit' do
    get edit_letter_path(id: @letter)
    assert_response :success
  end

  test 'should update letter' do
    patch letter_path(id: @letter), params: { letter: { name: 'example' } }
    assert_redirected_to data_path
  end

  test 'should destroy letter' do
    assert_difference('Letter.count', -1) do
      delete letter_path(id: @letter, format: :js)
    end
  end
end
