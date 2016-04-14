# coding: utf-8
# Тема чего-то.
#
# Поле +theme+ в таблице:
# * string
#
module Theme
  extend ActiveSupport::Concern

  ## Максимальная длинна.
  MAX_THEME = 255 # макс. длинна строк ограничена

  included do
    validates :theme,
              length: { maximum: MAX_THEME }

    before_validation :trim_theme
  end

  protected

  ## Укоротить длинну (если надо).
  def trim_theme
    self.theme = theme[0..(MAX_THEME - 1)] if theme.present?
  end
end
