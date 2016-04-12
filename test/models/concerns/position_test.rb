# coding: utf-8
require 'test_helper'

class PositionTest < ActiveSupport::TestCase
  setup do
    @instance = build([:forum, :letter, :letter_item].shuffle.sample)
  end

  test 'следующие по списку номера присваиваются' do
    model_name = instance_class.to_s.underscore.to_sym

    o1 = build(model_name, url: 'example.com/1')
    o2 = build(model_name, url: 'example.com/2')

    o1.save!
    o2.save!

    assert((o2.position > o1.position))
  end
end
