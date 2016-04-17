# coding: utf-8
# Запоминаем последнюю посещенную страницу.
#
# Консерва ApplicationController. При include в него должна быть одной
# из первых (чтобы выполняться как можно раньше).
#
# Потом можно будет вернуться на данный урл (напр. после успешной
# аутентификации как в SessionsController#create).
#
# Ньюансы:
#
# * <tt>session[:account_id]</tt> Здесь храним этот самый back_url
#
module BackUrl
  extend ActiveSupport::Concern

  included do
    after_action :set_back_url
  end

  protected

  ##
  # Возвращает то что сохранили в #set_back_url.
  #

  def back_url
    session[:back_url] if session[:back_url].present?
  end

  ##
  # Сохранить в session#back_url адрес последней посещенной
  # страницы.
  #
  # Посещенной по GET, причем не по AJAX-GET.
  #

  def set_back_url
    session[:back_url] = request.url if
      request.get? &&
      !request.xhr? &&
      !request.url.include?(SessionsController.controller_name)
  end
end
