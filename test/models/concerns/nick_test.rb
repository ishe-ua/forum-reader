# coding: utf-8
require 'test_helper'

class NickTest < ActiveSupport::TestCase
  setup do
    @instance = build(:user)
  end

  test 'обязательное поле' do
    instance.nick = nil
    assert_not instance.valid?
  end

  test 'уникальное' do
    instance.nick = instance_class.all.sample.nick
    assert_not instance.valid?
  end

  test 'можно только валидные имена' do
    instance.nick = 'left_nick'
    assert_not instance.valid?
  end

  test 'перед валидацией переводится в нижний регистр' do
    instance.nick = 'UsEr'
    instance.validate
    assert_equal instance.nick, 'user'
  end
end
