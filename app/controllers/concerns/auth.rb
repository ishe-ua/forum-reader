# Authentication.
#
# Concern for ApplicationController. Should be first or mostly first
# there.
#
module Auth
  extend ActiveSupport::Concern

  included do
    helper_method :signed_in?
    before_action :require_sign_in

    helper_method :current_account
    helper_method :current_user
  end

  protected

  def auto_sign_in(email)
    account = Account.find_by(email: email)
    session[:account_id] = account.id if account&.authenticate(password)
  end

  # Return true or String if error.
  #
  # Skip if Lock.

  def sign_in(email, password)
    account = Account.find_by(email: email)

    return t('sessions.errors.fail')   if account.nil?
    return t('sessions.errors.locked') if defined?(Lock) && account.locked?

    if account.authenticate(password)
      session[:account_id] = account.id
      true
    else
      t('auth.sign_in.fail')
    end
  end

  def sign_out
    session[:account_id] = nil
    session[:back_url]   = nil
  end

  # helper_method
  def signed_in?
    session[:account_id] ? true : false
  end

  # helper_method
  def current_account
    (@current_account ||= Account.find_by(id: session[:account_id])) if
      signed_in?
  end

  # helper_method
  def current_user
    (@current_user ||= current_account.user) if
      signed_in?
  end

  # Secure page filter
  def require_sign_in
    redirect_to new_session_path unless
      signed_in?
  end
end
