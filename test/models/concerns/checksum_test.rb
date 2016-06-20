require 'test_helper'

class ChecksumTest < ActiveSupport::TestCase
  setup do
    @instance = build(:feed_item)
  end

  test 'required field' do
    instance.checksum = nil
    assert instance.valid?
  end
end
