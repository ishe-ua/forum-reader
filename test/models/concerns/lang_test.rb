# coding: utf-8
require 'test_helper'

class LangTest < ActiveSupport::TestCase
  setup do
    @instance = build(:user)
  end

  test 'обязательное поле' do
    instance.lang = nil
    assert_not instance.valid?
  end

  test 'можно только поддерживаемые локали' do
    instance.lang = :aa
    assert_not instance.valid?
  end
end
