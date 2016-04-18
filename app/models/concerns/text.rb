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

    before_validation :trim_text
  end

  protected

  ## Укоротить длинну (если надо).
  def trim_text
    self.text = text[0..(MAX_TEXT - 1)] if text.present?
  end
end
