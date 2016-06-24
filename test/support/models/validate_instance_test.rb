# coding: utf-8
# Валидация @instance.
# Того, который объявляем в setup-методе.
#
module ValidateInstanceTest
  def test_instance_is_defined
    assert instance, '@instance прописан'
  end

  def test_instance_is_valid
    assert instance.valid?, "instance of #{instance.class} is valid"
  end
end
