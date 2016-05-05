# coding: utf-8
# Временная зона.
#
# Поле +timezone+ в таблице:
# * строка
#
module Timezone
  extend ActiveSupport::Concern

  ## Список временных зон.
  TZ_NAMES = ActiveSupport::TimeZone::MAPPING.values

  included do
    validates :timezone,

              presence: true,
              inclusion: { in: TZ_NAMES }
  end
end
