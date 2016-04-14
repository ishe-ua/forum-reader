# coding: utf-8
require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  setup do
    @instance = build(:account)
  end

  include ValidateInstanceTest
  include ValidateFixturesTest

  test 'email уникальный' do
    instance.email = instance_class.all.sample.email
    assert_not instance.valid?
  end
end
