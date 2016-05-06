# Field +text+ in table:
# * text
#
module Text
  extend ActiveSupport::Concern

  MAX_TEXT = 2048

  included do
    validates :text,
              length: { maximum: MAX_TEXT }

    before_validation :trim_text
  end

  protected

  def trim_text
    self.text = text[0..(MAX_TEXT - 1)] if text.present? &&
                                           text.length > MAX_TEXT
  end
end
