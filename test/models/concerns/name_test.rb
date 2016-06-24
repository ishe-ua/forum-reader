require 'test_helper'

class NameTest < ActiveSupport::TestCase
  setup do
    @instance = build([:forum, :letter, :letter_item].shuffle.sample)
  end

  test 'required field' do
    instance.name = nil
    assert_not instance.valid?
  end

  test 'trim if length more then const' do
    instance.name = 'a' * (instance.class::MAX_NAME * 2)
    assert instance.valid?
    assert_equal instance.name.length, instance.class::MAX_NAME
  end
end
