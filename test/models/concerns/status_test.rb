require 'test_helper'

class StatusTest < ActiveSupport::TestCase
  setup do
    @instance = [reader_sets(:ishe), mailer_sets(:ishe)].shuffle.sample
  end

  test 'required field' do
    instance.status = nil
    assert_not instance.valid?
  end

  test 'only supported values' do
    assert_raise { instance.status = 1_000_000 }
  end

  test '#change_status' do
    assert_equal instance.status, instance.class::ON
    assert instance.change_status
    assert_equal instance.status, instance.class::OFF
  end
end
