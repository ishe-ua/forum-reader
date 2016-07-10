require 'test_helper'

class SecretNameTest < ActiveSupport::TestCase
  setup do
    @instance = build(:mailer_set)
  end

  test 'required field' do
    instance.secret_name = nil
    assert_not instance.valid?
  end

  test 'unique' do
    instance.secret_name = instance.class.pluck(:secret_name).sample
    assert_not instance.valid?
  end

  test 'only in lower case' do
    instance.secret_name = 'aaBcc'
    assert_not instance.valid?
  end

  test 'only allowed chars' do
    instance.secret_name = 'aa_cc'
    assert_not instance.valid?
  end

  test '#secret_email' do
    instance.secret_name = 'a328'
    assert_equal instance.secret_email, "a328@#{APP::HOST}"
  end

  test '#secret_name_from' do
    assert_equal(
      instance.class.secret_name_from('user@example.com'),
      'user'
    )
  end

  test '#reset_secret_name' do
    dupped = instance.secret_name.dup
    assert instance.reset_secret_name
    assert_not_equal instance.secret_name, dupped
  end
end
