# coding: utf-8
# Подтверждение email.
#
# Поля в таблице:
#
# 1. +email_confirmation_at+ Когда подтвердили (nil - не подтвержденный)
# 2. +email_confirmation_token+
#
module EmailConfirmation
  extend ActiveSupport::Concern

  ## <em>Рекомендованный</em> размер токена.
  TOKEN_LENGTH = 40

  included do
    validates :email_confirmation_token,

              uniqueness: true,
              allow_nil: true
  end

  ## Email подтвержден или нет?
  def email_confirmed?
    email_confirmation_at ? true : false
  end

  ## Отметить email как подтвержденный.
  def confirm_email!
    update!(email_confirmation_at: Time.zone.now)
  end

  ## Отметить email как неподтвержденный.
  def unconfirm_email
    update! email_confirmation_at: nil,
            email_confirmation_token: self.class.gen_email_confirmation_token
  end

  class_methods do
    ## Генерим случайный токен для подтверждения email-адреса.
    def gen_email_confirmation_token
      s1 = ('a'..'z').to_a.shuffle
      s2 = (0..9)    .to_a.shuffle

      array = (s1 + s2).shuffle
      array[0..(TOKEN_LENGTH - 1)].join
    end
  end
end
