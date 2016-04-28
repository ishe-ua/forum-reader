# coding: utf-8
# Включено или выключено.
#
# Поле +status+ в таблице:
# * integer
#
module Status
  extend ActiveSupport::Concern

  ## Status is on.
  STATUS_ON = 'on'.freeze

  ## Status is off.
  STATUS_OFF = 'off'.freeze

  ## Допустимые значения.
  SUPPORTED_STATUSES = [STATUS_ON, STATUS_OFF].freeze

  included do
    enum status: SUPPORTED_STATUSES

    after_initialize :set_default_status

    validates :status,

              presence: true,
              inclusion: { in: SUPPORTED_STATUSES }
  end

  ## Изменить статус на противоположный.
  def change_status
    b1 = false
    b2 = false

    b1 = update!(status: STATUS_ON) if status == STATUS_OFF
    b2 = update!(status: STATUS_OFF) if status == STATUS_ON

    b1 || b2
  end

  protected

  ## Значение по умолчанию.
  def set_default_status
    self.status ||= self.class.statuses[:on]
  end
end
