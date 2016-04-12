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
  JABBER_CONFIRMATION_TOKEN_LENGTH = 40

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
    update!(jabber_confirmation_at: nil,
            jabber_confirmation_token: self.class.gen_jabber_confirmation_token)
  end

  class_methods do
    ## Генерим случайный токен для подтверждения jabber-адреса.
    def gen_jabber_confirmation_token
      s1 = ('a'..'z').to_a.shuffle
      s2 = (0..9)    .to_a.shuffle

      array = (s1 + s2).shuffle
      array[0..(JABBER_CONFIRMATION_TOKEN_LENGTH - 1)].join
    end
  end
end
