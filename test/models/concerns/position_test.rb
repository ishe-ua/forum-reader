# coding: utf-8

require 'test_helper'

class PositionTest < ActiveSupport::TestCase
  setup do
    @instance = build(%i(forum letter letter_item).shuffle.sample)
  end

  test 'следующие по списку номера присваиваются' do
    model_sym = instance.class.to_s.underscore.to_sym

    o1 = build(model_sym)
    o2 = build(model_sym)

    if model_sym != :letter
      o1.url = 'example.com/1'
      o2.url = 'example.com/2'
    end

    o1.save!
    o2.save!

    assert((o2.position > o1.position))
  end
end
