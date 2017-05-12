require 'application_system_test_case'

class RemovesTest < ApplicationSystemTestCase
  setup { sign_in }
  teardown { sign_out }

  test 'remove forum' do
    forum = forums(:reddit_ruby)
    assert_destroy(forum)
  end

  test 'remove letter' do
    letter = letters(:dev)
    assert_destroy(letter)
  end

  test 'remove letter item' do
    letter_item = letter_items(:lbua)
    assert_destroy(letter_item)
  end

  private

  def assert_destroy(instance)
    row_id = "##{instance.model_name.param_key}_#{instance.id}"
    find(row_id).first('.button-delete').click
    assert_no_text instance.name
  end
end
