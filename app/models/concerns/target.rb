# coding: utf-8
# Куда отправлять - на email или в jabber.
#
# Поле +target+ в таблице:
# * integer
# * непустое
#
module Target
  extend ActiveSupport::Concern

  ## Допустимые значения.
  VALID_TARGETS = %w(email jabber).freeze

  included do
    enum target: VALID_TARGETS

    validates :target,

              presence: true,
              inclusion: { in: VALID_TARGETS }
  end
end
