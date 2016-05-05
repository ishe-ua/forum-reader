# Time zone.
#
# Field +timezone+ in table:
# * string
#
module Timezone
  extend ActiveSupport::Concern

  SUPPORTED_TZ_NAMES = ActiveSupport::TimeZone::MAPPING.values

  included do
    validates :timezone,

              presence: true,
              inclusion: { in: SUPPORTED_TZ_NAMES }
  end
end
