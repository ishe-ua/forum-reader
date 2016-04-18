# coding: utf-8
require 'test_helper'

class TextTest < ActiveSupport::TestCase
  setup do
    @instance = build(:contact)
  end

  test "максимальная длинна ограничена и обрезается если надо" do
    instance.text = 'a' * (instance_class::MAX_TEXT * 2)
    assert instance.valid?
    assert_equal instance.text.length, instance_class::MAX_TEXT
  end
end
