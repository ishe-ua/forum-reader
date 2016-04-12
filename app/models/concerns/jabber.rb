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
  VALID_JABBER = Email::VALID_EMAIL

  included do
    before_validation :downcase_jabber, if: :jabber_changed?
    after_update :nullify_jabber_confirmation, if: :jabber_changed?

    validates :jabber,

              presence: true,
              uniqueness: true,

              format: {
                with: VALID_JABBER,
                message: I18n.t('activerecord.errors.invalid_format')
              }
  end

  protected

  ## Значение в нижний регистр.
  def downcase_jabber
    jabber.downcase!
  end

  ##
  # После изменения jabber становится не подтвержденным (see
  # JabberConfirmation).
  #

  def nullify_jabber_confirmation
    unconfirm_jabber
  end
end
