require 'test_helper'

class NickTest < ActiveSupport::TestCase
  setup do
    @instance = build(:user)
  end

  test 'required field' do
    instance.nick = nil
    assert_not instance.valid?
  end

  test 'uniqueness' do
    instance.nick = instance_class.all.sample.nick
    assert_not instance.valid?
  end

  test 'validate by regexp' do
    instance.nick = 'left_nick'
    assert_not instance.valid?
  end

  test 'downcase before validation' do
    instance.nick = 'UsEr'
    instance.validate
    assert_equal instance.nick, 'user'
  end
end
