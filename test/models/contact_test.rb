# coding: utf-8
require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  setup do
    @instance = build(:contact)
  end

  include ValidateInstanceTest
  include ValidateFixturesTest

  test 'обязательно должна быть тема сообщения' do
    instance.theme = nil
    assert_not instance.save
  end

  test 'обязательно должен быть текст сообщения' do
    instance.text = nil
    assert_not instance.save
  end

  test 'email не уникальный' do
    instance.email = instance_class.all.sample.email
    assert instance.valid?
  end
end
