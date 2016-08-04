# See Account
class AccountsController < ApplicationController
  before_action :set_account, only: [:edit, :update, :destroy]
  skip_before_action :require_sign_in, only: [:new, :create]

  include ConfirmEmail
  include ConfirmJabber

  include ResetPassword

  def new
    @account = Account.new
    # @account.build_user
  end

  # If success:
  # 1. AccountsMailer#welcome (throught 10 minutes)
  # 2. AccountsMailer#email_confirmation
  # 3. AdminMailer#new_registration
  #
  # Also CheckCompany.
  #
  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { send_emails_after_create_and_redirect_to_info; return }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  # If Email changed:
  #
  # 1. Email becomes unconfirmed
  # 2. Send AccountsMailer#email_confirmation
  #
  def update
    respond_to do |format|
      if @account.update(account_params)
        unconfirm_email && send_email_confirmation if new_email?
        format.html { redirect_to data_path }
      else
        format.html { render :edit }
      end
    end
  end

  # Deprecated
  def destroy
    raise 'Deprecated'
  end

  private

  def set_account
    @account = current_account # !!
  end

  def account_params
    params.require(:account)
          .permit(
            :name,
            :email,
            :password,
            :password_confirmation,
            user_attributes: [:id, :nick, :jabber, :lang, :country, :timezone]
          )
  end

  def send_emails_after_create_and_redirect_to_info
    AccountsMailer.welcome(@account)
                  .deliver_later!(queue_priority: 0)

    AccountsMailer.email_confirmation(@account)
                  .deliver_later!(queue_priority: 0)

    AdminMailer.new_registration(@account)
               .deliver_later!(queue_priority: 0)

    redirect_to info_path, notice: t('we_sent_you_email')
  end

  def new_email?
    @account.previous_changes['email'] &&
      @account.previous_changes['email'].any?
  end

  def unconfirm_email
    @account.unconfirm_email
  end

  def send_email_confirmation
    AccountsMailer.email_confirmation(@account).deliver_later(queue_priority: 0)
  end
end
