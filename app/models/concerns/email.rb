# Field +email+ in table:
# * string
# * unique index
#
module Email
  extend ActiveSupport::Concern

  # From gem 'devise'
  VALID_EMAIL = /\A[^@\s]+@([^@\s]+\.)+[^@\W]+\z/

  included do
    before_validation :downcase_email
    after_update :nullify_email_confirmation

    validates :email,
              presence: true,

              format: {
                with: VALID_EMAIL,
                message: I18n.t('activerecord.errors.invalid_format')
              }
  end

  protected

  def downcase_email
    email.downcase! if email_changed?
  end

  # Invoke after change Email (see EmailConfirmation)
  def nullify_email_confirmation
    unconfirm_email if saved_change_to_attribute?(:email)
  end
end
