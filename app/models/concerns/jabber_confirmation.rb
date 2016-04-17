# coding: utf-8
# Подтверждение Jabber.
#
# Поля в таблице:
#
# 1. +jabber_confirmation_at+ Когда подтвердили (nil - не подтвержденный)
# 2. +jabber_confirmation_token+
#
module JabberConfirmation
  extend ActiveSupport::Concern

  ## <em>Рекомендованный</em> размер токена.
  JABBER_CONFIRMATION_TOKEN_SIZE = 40

  included do
    after_initialize :set_default_jabber_confirmation_token

    validates :jabber_confirmation_token,

              presence: true,
              uniqueness: true
  end

  ## Подтвержден или нет?
  def jabber_confirmed?
    jabber_confirmation_at ? true : false
  end

  ## Отметить как подтвержденный.
  def confirm_jabber!
    update!(jabber_confirmation_at: Time.zone.now)
  end

  ## Отметить как неподтвержденный.
  def unconfirm_jabber
    update_columns(
      jabber_confirmation_at: nil,
      jabber_confirmation_token:
        Tokenizer.random_string(JABBER_CONFIRMATION_TOKEN_SIZE)
    )
  end

  protected

  ## Значение по умолчанию.
  def set_default_jabber_confirmation_token
    self.jabber_confirmation_token ||=
      Tokenizer.random_string(JABBER_CONFIRMATION_TOKEN_SIZE)
  end
end
