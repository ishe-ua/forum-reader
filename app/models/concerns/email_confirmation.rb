# coding: utf-8
# Подтверждение Email.
#
# Поля в таблице:
#
# 1. +email_confirmation_at+ Когда подтвердили (nil - не подтвержденный)
# 2. +email_confirmation_token+
#
module EmailConfirmation
  extend ActiveSupport::Concern

  ## <em>Рекомендованный</em> размер токена.
  EMAIL_CONFIRMATION_TOKEN_SIZE = 40

  included do
    validates :email_confirmation_token,

              uniqueness: true,
              allow_nil: true
  end

  ## Подтвержден или нет?
  def email_confirmed?
    email_confirmation_at ? true : false
  end

  ## Отметить как подтвержденный.
  def confirm_email!
    update!(email_confirmation_at: Time.zone.now)
  end

  ## Отметить как неподтвержденный.
  def unconfirm_email
    update_columns(
      email_confirmation_at: nil,
      email_confirmation_token:
        Tokenizer.random_string(EMAIL_CONFIRMATION_TOKEN_SIZE)
    )
  end
end
