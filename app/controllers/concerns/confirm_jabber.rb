# coding: utf-8
# Confirm Jabber.
#
# Face for JabberConfirmation.
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
    user = User.find_by(jabber_confirmation_token: params[:token])

    if user && confirm_j(user)
      auto_signin(user.account) # прописано в ConfirmEmail
      flash.notice = t 'success'
    else
      flash.alert = t 'fail'
    end

    redirect_to info_path
  end

  private

  def confirm_j(user)
    user.confirm_jabber unless user.jabber_confirmed?
    user.jabber_confirmed?
  end
end
