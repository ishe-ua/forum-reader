# coding: utf-8
# Управление локалью.
#
class LocaleController < ApplicationController
  skip_before_action :require_sign_in

  ## Изменить текущую локаль.
  def change
    I18n.locale = params[:lang]
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end
end
