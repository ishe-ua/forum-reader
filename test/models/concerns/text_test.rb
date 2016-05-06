require 'test_helper'

class TextTest < ActiveSupport::TestCase
  setup do
    @instance = build([:contact, :feed_item].shuffle.sample)
  end

  test 'max length is limited and trim if need' do
    instance.text = 'a' * (instance_class::MAX_TEXT * 2)
    assert instance.valid?
    assert_equal instance.text.length, instance_class::MAX_TEXT
  end
end
