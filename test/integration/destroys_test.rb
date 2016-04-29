# coding: utf-8
require 'test_helper'

## Удалить forum/letter_item.
class DestroysTest < ActionDispatch::IntegrationTest
  setup do
    sign_in(accounts(:ishe))
    visit data_path
  end

  test 'destroy forum' do
    assert_destroy(forums(:reddit_ruby))
  end

  test 'destroy letter_item' do
    assert_destroy(letter_items(:opennet))
  end

  private

  def assert_destroy(resource)
    resource_name = resource.class.name.underscore
    row_id = "##{resource_name}_#{resource.id}"

    within(row_id) { click_link I18n.t(:destroy) }
    assert page.has_no_text?(resource.name)
  end
end
