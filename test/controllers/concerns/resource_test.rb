# coding: utf-8
require 'test_helper'

class ResourceTest < ActionController::TestCase
  tests AccountsController

  setup do
    @account = accounts(:ishe)
    sign_in(@account)

    @controller.send(:set_resource)
  end

  test '#resource_name' do
    assert_equal @controller.send(:resource_name), 'account'
  end

  test '#resources_name' do
    assert_equal @controller.send(:resources_name), 'accounts'
  end

  test '#set_resource' do
    assert @controller.instance_variable_defined?(:@account)
  end

  test '#resource' do
    assert_equal @controller.send(:resource), @account
  end

  test '#resource_class' do
    assert_equal @controller.send(:resource_class), @account.class
  end
end
