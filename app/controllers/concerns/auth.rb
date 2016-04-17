# coding: utf-8
# Аутентификация.
#
# Консерва ApplicationController. При include в него должна быть одной
# из первых (чтобы выполняться как можно раньше), а лучше первой.
#
# Ньюансы:
#
# * <tt>Прописан фильтр защиты всех страниц</tt>
# * Id залогиненного храним в <tt>session[:account_id]</tt>
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

  ##
  # Залогиниться только по email, т.е. без пароля.
  #

  def auto_sign_in(email)
    account = Account.find_by(email: email)
    session[:account_id] = account.id if account
  end

  ##
  # Залогиниться.
  #
  # Lock -нутые не залогинятся (если Lock-механизм доступен).
  #
  # Возвращаем:
  # 1. true   Залогинились
  # 2. String Сообщение
  #

  def sign_in(email, password)
    account = Account.find_by(email: email)

    return t('auth.sign_in.fail')   if account.nil?
    return t('auth.sign_in.locked') if defined?(Lock) && account.locked?

    if account.authenticate(password)
      session[:account_id] = account.id
      true
    else
      t('auth.sign_in.fail')
    end
  end

  ## Разлогиниться.
  def sign_out
    session[:account_id] = nil
    session[:back_url]   = nil
  end

  ##
  # Залогинены или нет?
  #
  # helper_method
  #

  def signed_in?
    session[:account_id] ? true : false
  end

  ##
  # Текущий залогиненный Account или nil.
  #
  # helper_method
  #

  def current_account
    @current_account ||= Account.find_by(id: session[:account_id]) if
      signed_in?
  end

  ##
  # Текущий залогиненный User или nil.
  #
  # helper_method
  #

  def current_user
    @current_user ||= current_account.user if
      signed_in?
  end

  ## Фильтр защиты страницы.
  def require_sign_in
    redirect_to new_session_path unless
      signed_in?
  end
end
