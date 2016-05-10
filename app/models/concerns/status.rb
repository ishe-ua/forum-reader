# +On+ or +Off+.
#
# Field +status+ in table:
# * integer
#
module Status
  extend ActiveSupport::Concern

  ON = 'on'.freeze
  OFF = 'off'.freeze

  SUPPORTED_STATUSES = [ON, OFF].freeze # TODO: remove

  included do
    enum status: SUPPORTED_STATUSES

    after_initialize :set_default_status

    validates :status,

              presence: true,
              inclusion: { in: SUPPORTED_STATUSES }
  end

  def change_status
    s = status == ON ? OFF : ON
    update!(status: s)
  end

  protected

  def set_default_status
    self.status ||= self.class.statuses[:on]
  end
end
