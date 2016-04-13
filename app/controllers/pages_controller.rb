# coding: utf-8
# Статические страницы.
#
# Все они защищены Auth#require_sign_in. Во избежание "несчастных
# случаев на производстве", открываем доступ к каждой из них отдельно.
#
class PagesController < ApplicationController
  skip_before_action :require_sign_in, only:
                                         [
                                           :home,
                                           :help,
                                           :info
                                         ]

  ## Стартовая приложения.
  def home
    # TODO: redirect_to pages_data_path if signed_in?
  end

  ## Как пользоваться.
  def help
  end

  ##
  # Инфо-страница.
  #
  # Показываем flash-сообщения или redirect на стартовую если те
  # пустые.
  #

  def info
    redirect_to(root_path) if flash.notice.blank? && flash.alert.blank?
  end

  ##
  # Данные пользователя.
  #
  # Стартовая для залогиненных.
  #

  def data
  end

  ## Настройки.
  def settings
  end
end
