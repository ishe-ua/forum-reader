require 'test_helper'

class ThemeTest < ActiveSupport::TestCase
  setup do
    @instance = build(%i[contact feed_item].shuffle.sample)
  end

  test 'max length is limited and trim if need' do
    instance.theme = 'a' * (instance.class::MAX_THEME * 2)
    assert instance.valid?
    assert_equal instance.theme.length, instance.class::MAX_THEME
  end
end
