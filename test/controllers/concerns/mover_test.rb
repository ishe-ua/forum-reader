# coding: utf-8
require 'test_helper'

class MoverTest < ActionController::TestCase
  tests ForumsController

  setup do
    sign_in(accounts(:ishe))

    @resource1 = forums(:reddit_ruby)
    @resource2 = forums(:reddit_rails)
  end

  test '#move_up' do
    assert_resource1_less_resource2('1-й выше')
    patch :move_up, id: @resource2, format: :js

    assert_response :success
    assert_resource2_less_resource1('2-й выше')
  end

  test '#move_down' do
    assert_resource1_less_resource2('1-й выше')
    patch :move_down, id: @resource1, format: :js

    assert_response :success
    assert_resource2_less_resource1('2-й выше')
  end

  private

  def assert_resource1_less_resource2(msg = '1-й выше')
    assert @resource1.reload.position < @resource2.reload.position, msg
  end

  def assert_resource2_less_resource1(msg = '2-й выше')
    assert @resource2.reload.position < @resource1.reload.position, msg
  end
end
