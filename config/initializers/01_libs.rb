# coding: utf-8
# Подгружаем либы
#

require Rails.root.join('lib', 'app.rb')
require Rails.root.join('lib', 'clock.rb')

##

require Rails.root.join('lib/reader', 'reader.rb')
require Rails.root.join('lib/notificator', 'notificator.rb')

require Rails.root.join('lib/talker', 'talker.rb')
require Rails.root.join('lib/reminder', 'reminder.rb')
