# Schedule for Letter.
#
# Days of week and time when deliver Letter to User.
#
# Fields in table:
# * day (1..7)
# * hour
# * minute
#
module Schedule
  extend ActiveSupport::Concern

  SUPPORTED_HOURS = (0..23).to_a
  SUPPORTED_MINUTES = APP::SUPPORTED_MINUTES

  included do
    after_initialize :set_default_schedule

    validates :hour, presence: true, inclusion: { in: SUPPORTED_HOURS }
    validates :minute, presence: true, inclusion: { in: SUPPORTED_MINUTES }
  end

  protected

  def set_default_schedule
    self.d6 = true if d6.nil?
    self.hour ||= 17
    self.minute ||= 30
  end
end
