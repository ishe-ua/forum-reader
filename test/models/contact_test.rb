require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  setup do
    @instance = build(:contact)
  end

  include ValidateInstanceTest
  include ValidateFixturesTest

  test 'theme required' do
    instance.theme = nil
    assert_not instance.valid?
  end

  test 'text required' do
    instance.text = nil
    assert_not instance.valid?
  end

  test 'email not uniqueness' do
    instance.email = instance_class.all.sample.email
    assert instance.valid?
  end
end
