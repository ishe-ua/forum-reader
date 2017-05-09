# Field +jabber+ in table:
# * string
# * unique index
#
module Jabber
  extend ActiveSupport::Concern

  # From gem 'devise'
  VALID_JABBER = Email::VALID_EMAIL

  included do
    before_validation :downcase_jabber
    after_update :nullify_jabber_confirmation

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
    jabber.downcase! if jabber_changed?
  end

  # Invoke after change Jabber (see JabberConfirmation)
  def nullify_jabber_confirmation
    unconfirm_jabber if saved_change_to_attribute?(:jabber)
  end
end
