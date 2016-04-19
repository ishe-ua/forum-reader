# coding: utf-8
require 'test_helper'

class ReaderSetTest < ActiveSupport::TestCase
  setup do
    @instance = reader_sets(:mary)
  end

  include ValidateInstanceTest
  include ValidateFixturesTest

  test 'user_id обязательно' do
    instance.user_id = nil
    assert_not instance.valid?
  end

  test 'user_id уникален' do
    dup = instance_class.new(instance.attributes)
    assert_not dup.valid?
  end
end
