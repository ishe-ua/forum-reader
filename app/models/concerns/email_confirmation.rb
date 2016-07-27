# Fields in table:
#
# 1. +email_confirmation_at+ When confirmed (nil - unconfirmed)
# 2. +email_confirmation_token+
#
module EmailConfirmation
  extend ActiveSupport::Concern

  EMAIL_CONFIRMATION_TOKEN_SIZE = 40

  included do
    after_initialize :set_default_email_confirmation_token

    validates :email_confirmation_token,

              presence: true,
              uniqueness: true
  end

  def email_confirmed?
    email_confirmation_at ? true : false
  end

  def confirm_email
    update!(email_confirmation_at: Time.zone.now)
  end

  def unconfirm_email
    update_columns(
      email_confirmation_at: nil,
      email_confirmation_token:
        Utils::Tokenizer.gen_random_string(EMAIL_CONFIRMATION_TOKEN_SIZE)
    )
  end

  protected

  def set_default_email_confirmation_token
    self.email_confirmation_token ||=
      Utils::Tokenizer.gen_random_string(EMAIL_CONFIRMATION_TOKEN_SIZE)
  end
end
