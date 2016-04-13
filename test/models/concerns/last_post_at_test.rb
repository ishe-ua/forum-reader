# coding: utf-8
require 'test_helper'

class LastPostAtTest < ActiveSupport::TestCase
  setup do
    @instance = build([:forum, :letter, :letter_item].shuffle.sample)
  end

  test 'обязательное поле' do
    instance.last_post_at = nil
    assert_not instance.valid?
  end
end
