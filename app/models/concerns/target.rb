# coding: utf-8
# Куда отправлять - на email или в jabber.
#
# Поле +target+ в таблице:
# * integer
#
module Target
  extend ActiveSupport::Concern

  ## Допустимые значения.
  SUPPORTED_TARGETS = %w(email jabber).freeze

  included do
    enum target: SUPPORTED_TARGETS

    after_initialize :set_default_target

    validates :target,

              presence: true,
              inclusion: { in: SUPPORTED_TARGETS }
  end

  protected

  ## Значение по умолчанию.
  def set_default_target
    self.target ||= self.class.targets[:jabber]
  end
end
