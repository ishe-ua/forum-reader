# coding: utf-8
# Джаббер.
#
# Поле +jabber+ в таблице:
# * строка
# * unique-индекс
#
module Jabber
  extend ActiveSupport::Concern

  ## Валидный Email (взято из gem 'devise').
  REGEXP = /\A[^@\s]+@([^@\s]+\.)+[^@\W]+\z/

  included do
    before_validation :downcase_jabber, if: :jabber_changed?

    validates :jabber,
              uniqueness: true,

              format: {
                with: REGEXP,
                message: I18n.t('activerecord.errors.invalid_format')
              }
  end

  protected

  ## Значение в нижний регистр.
  def downcase_jabber
    jabber.downcase!
  end
end
