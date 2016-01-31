# coding: utf-8
##
# Каталог - расположение фикстур проекта.
#

def fixtures_path
  ActiveRecord::Tasks::DatabaseTasks.fixtures_path
end
