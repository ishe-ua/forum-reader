# coding: utf-8
# Текст чего-то.
#
# Поле +text+ в таблице:
# * text Тип поля, т.е. text: text
#
module Text
  extend ActiveSupport::Concern

  ## Максимальная длинна.
  MAX_LENGTH = 1024

  included do
    validates :text,
              length: { maximum: MAX_LENGTH }
  end
end
