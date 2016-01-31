# coding: utf-8
##
# Тестирование объектов.
# @instance - должен быть объявлен в setup.
#

## Like subject.
def instance
  @instance
end

## Like described_class.
def instance_class
  instance.class
end
