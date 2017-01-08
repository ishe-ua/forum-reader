require 'test_helper'

class ForumsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:ishe)
    @forum = @user.forums.first

    sign_in(@user.account)
  end

  test 'should get new' do
    get new_forum_path
    assert_response :success
  end

  test 'should create forum' do
    assert_difference('Forum.count') do
      post forums_path, params: {
        forum: {
          user_id: @user.id,
          name: 'example',
          url: 'example.com/feed'
        }
      }

      assert_redirected_to data_path
    end
  end

  test 'should get edit' do
    get edit_forum_path(id: @forum)
    assert_response :success
  end

  test 'should update forum' do
    patch forum_path(id: @forum), params: {
      forum: {
        name: 'example',
        url: 'example.com/feed/17'
      }
    }

    assert_redirected_to data_path
  end

  test 'should destroy forum' do
    assert_difference('Forum.count', -1) do
      delete forum_path(id: @forum, format: :js)
    end
  end
end
