# Field +jabber+ in table:
# * string
# * unique index
#
module Jabber
  extend ActiveSupport::Concern

  # From gem 'devise'
  VALID_JABBER = Email::VALID_EMAIL

  included do
    before_validation :downcase_jabber, if: :jabber_changed?
    after_update :nullify_jabber_confirmation, if: :jabber_changed?

    validates :jabber,

              allow_blank: true,
              uniqueness: true,

              format: {
                with: VALID_JABBER,
                message: I18n.t('activerecord.errors.invalid_format')
              }
  end

  protected

  def downcase_jabber
    jabber.downcase!
  end

  # Invoke after change Jabber (see JabberConfirmation)
  def nullify_jabber_confirmation
    unconfirm_jabber
  end
end
