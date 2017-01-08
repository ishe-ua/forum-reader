require 'test_helper'

class LetterItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @letter_item = letter_items(:atytarenko)
    @letter = @letter_item.letter
    @user = @letter.user

    sign_in(@user.account)
  end

  test 'should get new' do
    get new_letter_item_path
    assert_response :success
  end

  test 'should create letter_item' do
    assert_difference('LetterItem.count') do
      post letter_items_path, params: { letter_item: {
        letter_id: @letter.id,
        name: 'example',
        url: 'example.com/rss'
      } }

      assert_redirected_to data_path
    end
  end

  test 'should get edit' do
    get edit_letter_item_path(id: @letter_item)
    assert_response :success
  end

  test 'should update letter_item' do
    patch letter_item_path(id: @letter_item), params: {
      letter_item: {
        name: 'example',
        letter_id: @letter.id
      }
    }

    assert_redirected_to data_path
  end

  test 'should destroy letter_item' do
    assert_difference('LetterItem.count', -1) do
      delete letter_item_path(id: @letter_item, format: :js)
    end
  end
end
