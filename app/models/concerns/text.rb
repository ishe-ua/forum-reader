# coding: utf-8
# Текст чего-то.
#
# Поле +text+ в таблице:
# * text
#
module Text
  extend ActiveSupport::Concern

  ## Максимальная длинна.
  MAX_TEXT = 2048

  included do
    validates :text,
              length: { maximum: MAX_TEXT }
  end
end
