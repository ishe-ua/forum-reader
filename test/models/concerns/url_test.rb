# coding: utf-8
require 'test_helper'

class UrlTest < ActiveSupport::TestCase
  setup do
    @instance = build([:forum, :letter_item, :feed, :feed_item].shuffle.sample)
  end

  test 'обязательное поле' do
    instance.url = nil
    assert_not instance.valid?
  end

  test 'должен быть валидным по regexp' do
    instance.url = 'xx'
    assert instance.valid?
  end

  test 'переводится в нижний регистр' do
    instance.url = 'httP://eXample.com'
    instance.save!
    assert_equal instance.url, 'http://example.com'
  end

  test 'если надо - добавляется протокол' do
    instance.url = 'example.com'
    instance.save!
    assert_equal instance.url, 'http://example.com'
  end

  test 'если не надо - протокол не добавляется' do
    instance.url = 'https://example.com'
    instance.save!
    assert_equal instance.url, 'https://example.com'
  end
end
