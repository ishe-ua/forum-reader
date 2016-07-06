# Validate @instance (see +setup+ method in model tests)
module ValidateInstanceTest
  def test_instance_is_defined
    assert instance, '@instance defined'
  end

  def test_instance_is_valid
    assert instance.valid?, "instance of #{instance.class} is valid"
  end
end
