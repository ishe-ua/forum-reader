# Field +name+ in table:
# * string
#
module Name
  extend ActiveSupport::Concern

  MAX_NAME = 256

  included do
    validates :name,
              presence: true,

              length: { maximum: MAX_NAME }

    before_validation :trim_name
  end

  protected

  def trim_name
    self.name = name[0..(MAX_NAME - 1)] if name.present? &&
                                           name.length > MAX_NAME
  end
end
