# coding: utf-8
# Подтвердить Jabber.
#
# Морда для JabberConfirmation.
#
# Консерва AccountsController.
#
module ConfirmJabber
  extend ActiveSupport::Concern

  included do
    skip_before_action :require_sign_in, only: :confirm_jabber
  end

  ##
  # GET /accounts/confirm_jabber/:token
  #
  # Выполняется при переходе пипла по ссылке в письме
  # AccountsMailer#jabber_confirmation.
  #

  def confirm_jabber
    account = Account.find_by(jabber_confirmation_token: params[:token])

    if account && confirm_j(account)
      auto_signin(account) # прописано в ConfirmEmail
      flash.notice = t 'success'
    else
      flash.alert = t 'fail'
    end

    redirect_to info_path
  end

  private

  def confirm_j(account)
    account.confirm_jabber! unless account.jabber_confirmed?
    account.jabber_confirmed?
  end
end
