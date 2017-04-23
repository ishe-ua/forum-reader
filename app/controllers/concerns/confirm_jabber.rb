# Confirm Jabber.
#
# See JabberConfirmation
module ConfirmJabber
  extend ActiveSupport::Concern

  included do
    skip_before_action :require_sign_in, only: :confirm_jabber
  end

  # GET /accounts/confirm_jabber/:token
  #
  # Run after click by link from AccountsMailer#jabber_confirmation

  def confirm_jabber
    user = User.find_by(jabber_confirmation_token: params[:token])

    if user && attempt_confirm_j(user)
      auto_signin(user.account) # see ConfirmEmail
      flash.notice = t 'success'
    else
      flash.alert = t 'fail'
    end

    redirect_to info_path
  end

  # Send text from AccountsMailer#jabber_confirmation to Jabber
  # throught Reader::ReplyJob.
  #
  # Like ConfirmEmail#repeat_email_confirmation

  def repeat_jabber_confirmation
    text = AccountsMailer.jabber_confirmation(current_account).body.encoded
    Reader::ReplyJob.perform_later(text, current_user.jabber)
    redirect_to info_path, notice: t(:we_sent_you_jabber)
  end


  private

  def attempt_confirm_j(user)
    user.confirm_jabber unless user.jabber_confirmed?
    user.jabber_confirmed?
  end
end
