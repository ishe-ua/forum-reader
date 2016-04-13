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
    validates :jabber_confirmation_token,

              uniqueness: true,
              allow_nil: true
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
end
