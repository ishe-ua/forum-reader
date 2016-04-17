# coding: utf-8
# Сессии пользователей.
#
# Т.е. залогинить / разлогинить Account.
# Также система аутентификации включает:
#
# 1. Auth
# 2. BackUrl
# 3. I18n in auth.en.yml
#
class SessionsController < ApplicationController
  before_action :downcase_email, only: :create
  skip_before_action :require_sign_in, except: :destroy

  ## Показать страницу ввода email и пароля.
  def new
    redirect_to(root_path) if signed_in?
  end

  ##
  # Создать сессию.
  #
  # Lock -нутые не залогинятся.
  #
  # Входящие данные в параметрах:
  #
  # * <tt>params[:email]</tt>
  # * <tt>params[:password]</tt>
  #
  # Возвращаем:
  #
  # * <tt>flash[:alert]</tt> с ошибкой если что-то не так.
  #

  def create
    b = sign_in(params[:email], params[:password])
    if b == true
      url = back_url || root_path
      redirect_to url
    else
      flash.alert = b
      render :new
    end
  end

  ## Удалить сессию.
  def destroy
    sign_out if signed_in?
    redirect_to root_path
  end

  protected

  ## Чтобы можно было логиниться с email в любом регистре.
  def downcase_email
    params[:email].downcase! if params[:email].present?
  end
end
