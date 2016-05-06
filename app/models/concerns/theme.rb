# Field +theme+ in table:
# * string
#
module Theme
  extend ActiveSupport::Concern

  MAX_THEME = 255 # limited by PostgreSQL String type

  included do
    validates :theme,
              length: { maximum: MAX_THEME }

    before_validation :trim_theme
  end

  protected

  def trim_theme
    self.theme = theme[0..(MAX_THEME - 1)] if theme.present? &&
                                              theme.length > MAX_THEME
  end
end
