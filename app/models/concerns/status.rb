# coding: utf-8
# Включено или выключено.
#
# Поле +status+ в таблице:
# * integer
# * непустое
#
module Status
  extend ActiveSupport::Concern

  ## Допустимые значения.
  SUPPORTED_STATUSES = %w(on off).freeze

  included do
    enum status: SUPPORTED_STATUSES

    after_initialize :set_default_status

    validates :status,

              presence: true,
              inclusion: { in: SUPPORTED_STATUSES }
  end

  protected

  ## Значение по умолчанию.
  def set_default_status
    self.status ||= self.class.statuses[:on]
  end
end
