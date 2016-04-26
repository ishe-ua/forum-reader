# coding: utf-8
require 'test_helper'

class MoverTest < ActionController::TestCase
  tests [ForumsController, LettersController].shuffle.sample # TODO: LetterItems

  setup do
    account = accounts(:ishe)
    resources_name = @controller.send(:resources_name)

    @resource1 = account.user.send(resources_name).first
    @resource2 = account.user.send(resources_name).second

    sign_in(account)
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
