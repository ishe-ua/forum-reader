##
# Time zone.
#
# Field +timezone+ in table:
# * string
#
module Timezone
  extend ActiveSupport::Concern

  ## Available tz names.
  TZ_NAMES = ActiveSupport::TimeZone::MAPPING.values

  included do
    validates :timezone,

              presence: true,
              inclusion: { in: TZ_NAMES }
  end
end
