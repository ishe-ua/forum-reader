##
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

  ## Available hours.
  HOURS = (0..23).to_a

  ## Available minutes.
  MINUTES = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55].freeze

  included do
    after_initialize :set_default_schedule

    validates :hour, presence: true, inclusion: { in: HOURS }
    validates :minute, presence: true, inclusion: { in: MINUTES }
  end

  protected

  ## Default values.
  def set_default_schedule
    self.d6 = true if d6.nil?
    self.hour ||= 17
    self.minute ||= 30
  end
end
