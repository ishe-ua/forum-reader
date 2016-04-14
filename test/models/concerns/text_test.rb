# coding: utf-8
require 'test_helper'

class TextTest < ActiveSupport::TestCase
  setup do
    @instance = build(:contact)
  end

  test 'максимальная длинна ограничена' do
    instance.text = 'a' * (instance_class::MAX_LENGTH + 1)
    assert_not instance.valid?
  end
end
