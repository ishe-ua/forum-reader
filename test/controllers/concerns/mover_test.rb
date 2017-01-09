require 'test_helper'

class MoverTest < ActionDispatch::IntegrationTest
  setup do
    account = accounts(:ishe)
    @resources_name = ['forums', 'letters'].sample

    @resource1 = account.user.send(@resources_name).first
    @resource2 = account.user.send(@resources_name).second

    sign_in(account)
  end

  test '#move_up' do
    url = "move_up_#{@resources_name.singularize}_path"

    assert_resource1_less_resource2('1 higher')
    patch send(url, id: @resource2, format: :js)

    assert_response :success
    assert_resource2_less_resource1('2 higher')
  end

  test '#move_down' do
    url = "move_down_#{@resources_name.singularize}_path"

    assert_resource1_less_resource2('1 higher')
    patch send(url, id: @resource1, format: :js)

    assert_response :success
    assert_resource2_less_resource1('2 higher')
  end

  private

  def assert_resource1_less_resource2(msg = '1 higher')
    assert @resource1.reload.position < @resource2.reload.position, msg
  end

  def assert_resource2_less_resource1(msg = '2 higher')
    assert @resource2.reload.position < @resource1.reload.position, msg
  end
end
