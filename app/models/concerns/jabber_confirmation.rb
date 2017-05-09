# Fields in table:
#
# 1. +jabber_confirmation_at+ When confirmed (nil - unconfirmed)
# 2. +jabber_confirmation_token+
#
module JabberConfirmation
  extend ActiveSupport::Concern

  JABBER_CONFIRMATION_TOKEN_SIZE = 15

  included do
    after_initialize :set_default_jabber_confirmation_token

    validates :jabber_confirmation_token,

              presence: true,
              uniqueness: true
  end

  def jabber_confirmed?
    jabber_confirmation_at ? true : false
  end

  def confirm_jabber
    update!(jabber_confirmation_at: Time.zone.now)
  end

  def unconfirm_jabber
    update_columns(
      jabber_confirmation_at: nil,
      jabber_confirmation_token:
        Utils::Tokenizer.gen_random_string(JABBER_CONFIRMATION_TOKEN_SIZE)
    )
  end

  protected

  def set_default_jabber_confirmation_token
    self.jabber_confirmation_token ||=
      Utils::Tokenizer.gen_random_string(JABBER_CONFIRMATION_TOKEN_SIZE)
  end
end
