# coding: utf-8
# Почтовый адрес.
#
# Поле +email+ в таблице:
# * строка
# * unique-индекс
#
module Email
  extend ActiveSupport::Concern

  ## Валидный Email (взято из gem 'devise').
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

  ## Значение в нижний регистр.
  def downcase_email
    email.downcase!
  end

  ##
  # После изменения email становится не подтвержденным (see
  # EmailConfirmation).
  #

  def nullify_email_confirmation
    unconfirm_email
  end
end
