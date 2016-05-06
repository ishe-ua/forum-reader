require 'test_helper'

class ThemeTest < ActiveSupport::TestCase
  setup do
    @instance = build([:contact, :feed_item].shuffle.sample)
  end

  test 'max length is limited and trim if need' do
    instance.theme = 'a' * (instance_class::MAX_THEME * 2)
    assert instance.valid?
    assert_equal instance.theme.length, instance_class::MAX_THEME
  end
end
