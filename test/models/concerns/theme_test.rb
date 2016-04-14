# coding: utf-8
require 'test_helper'

class ThemeTest < ActiveSupport::TestCase
  setup do
    @instance = build(:contact)
  end

  test "максимальная длинна ограничена и обрезается если надо" do
    instance.theme = 'a' * (instance_class::MAX_THEME * 2)
    assert instance.valid?
    assert_equal instance.theme.length, instance_class::MAX_THEME
  end
end
