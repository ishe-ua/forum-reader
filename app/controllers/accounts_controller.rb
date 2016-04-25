# coding: utf-8
# Морда для Account.
#
class AccountsController < ApplicationController
  before_action :set_account, only:
                                [
                                  :edit,
                                  :update,
                                  :destroy
                                ]

  skip_before_action :require_sign_in, only:
                                         [
                                           :new,
                                           :create
                                         ]

  include ConfirmEmail
  include ConfirmJabber

  include ResetPassword

  ##
  # GET /accounts/new
  #
  # Показать форму регистрации новеньких.
  #

  def new
    @account = Account.new
    @account.build_user
  end

  ##
  # POST /accounts
  #
  # Создать.
  #
  # Если все хорошо - шлем письма:
  #
  # 1. AccountsMailer#welcome (доставляется через 10 минут)
  # 2. AccountsMailer#email_confirmation
  # 3. AdminMailer#new_registration
  #
  # Также помним о существовании CheckCompany.
  #

  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { send_emails_after_create_and_redirect_to_info }
      else
        format.html { render :new }
      end
    end
  end

  ##
  # GET /accounts/1/edit
  #
  # Показать страницу редактирования.
  #

  def edit
  end

  ##
  # PATCH/PUT /accounts/1
  #
  # Обновить данные.
  #
  # Если изменился email:
  #
  # 1. Новый ящик становится не подтвержденным
  # 2. Для подтверждения шлем AccountsMailer#email_confirmation
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

  ##
  # DELETE /accounts/1
  #
  # Удалить, <tt>запрещенная операция</tt>.
  #

  def destroy
    raise 'Deprecated'
  end

  private

  def set_account
    @account = current_account # важно!!
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
