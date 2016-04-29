# coding: utf-8
# Включено или выключено.
#
# Поле +status+ в таблице:
# * integer
#
module Status
  extend ActiveSupport::Concern

  ## Status is on.
  ON = 'on'.freeze

  ## Status is off.
  OFF = 'off'.freeze

  ## Допустимые значения.
  SUPPORTED_STATUSES = [ON, OFF].freeze

  included do
    enum status: SUPPORTED_STATUSES

    after_initialize :set_default_status

    validates :status,

              presence: true,
              inclusion: { in: SUPPORTED_STATUSES }
  end

  ## Изменить статус на противоположный.
  def change_status
    s = status == ON ? OFF : ON
    update!(status: s)
  end

  protected

  ## Значение по умолчанию.
  def set_default_status
    self.status ||= self.class.statuses[:on]
  end
end
