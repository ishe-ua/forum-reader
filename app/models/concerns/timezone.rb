# coding: utf-8
# Временная зона.
#
# Поле +timezone+ в таблице:
# * строка
# * непустое
#
module Timezone
  extend ActiveSupport::Concern

  ## Список временных зон.
  TZ_NAMES = ActiveSupport::TimeZone.all.map(&:name)

  included do
    validates :timezone,

              presence: true,
              inclusion: { in: TZ_NAMES }
  end
end
