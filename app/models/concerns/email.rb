# Field +email+ in table:
# * string
# * unique index
#
module Email
  extend ActiveSupport::Concern

  # From gem 'devise'
  VALID_EMAIL = /\A[^@\s]+@([^@\s]+\.)+[^@\W]+\z/

  included do
    before_validation :downcase_email, if: :email_changed?
    after_update :nullify_email_confirmation, if: :email_changed?

    validates :email,
              presence: true,

              format: {
                with: VALID_EMAIL,
                message: I18n.t('activerecord.errors.invalid_format')
              }
  end

  protected

  def downcase_email
    email.downcase!
  end

  # Invoke after change Email (see EmailConfirmation)
  def nullify_email_confirmation
    unconfirm_email
  end
end
