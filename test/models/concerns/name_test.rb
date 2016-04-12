# coding: utf-8
require 'test_helper'

class NameTest < ActiveSupport::TestCase
  setup do
    @instance = build([:forum, :letter, :letter_item].shuffle.sample)
  end

  test "обязательное поле" do
    instance.name = nil
    assert_not instance.valid?
  end

  test "максимальная длинна ограничена и обрезается если надо" do
    instance.name = 'a' * (Name::MAX_NAME * 2)
    assert instance.valid?
    assert_equal instance.name.length, Name::MAX_NAME
  end
end
