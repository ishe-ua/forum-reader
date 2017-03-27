require 'test_helper'

class UrlTest < ActiveSupport::TestCase
  setup do
    @instance = build(%i(forum letter_item feed feed_item).shuffle.sample)
  end

  test 'required field' do
    instance.url = nil
    assert_not instance.valid?
  end

  test 'valid by regexp' do
    instance.url = 'xx'
    assert instance.valid?
  end

  test '#downcase_url' do
    instance.url = 'httP://eXample.com'
    instance.save!
    assert_equal instance.url, 'http://example.com'
  end

  test '#add_http_or_https if need' do
    instance.url = 'example.com'
    instance.save!
    assert_equal instance.url, 'http://example.com'
  end

  test 'not #add_http_or_https if do not need' do
    instance.url = 'https://example.com'
    instance.save!
    assert_equal instance.url, 'https://example.com'
  end
end
