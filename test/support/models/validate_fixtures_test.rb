# coding: utf-8
# Валидация фикстур.
# Проверяем все имеющиеся для конкретной модели.
#
module ValidateFixturesTest
  def test_validate_fixtures
    instance_class.all.each do |obj|
      assert obj.valid?, "fixture of the class #{instance_class} is valid"
    end
  end
end
