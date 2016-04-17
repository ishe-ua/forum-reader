# coding: utf-8
# Установить локаль интерфейса пользователя, точнее следить за
# выбранной.
#
# Консерва ApplicationController.
#
module TrackLocale
  extend ActiveSupport::Concern

  included do
    before_action :track_locale
  end

  protected

  ## Установить текущую выбранную, взяв ее из session.
  def track_locale
    I18n.locale = session[:current_locale] || I18n.default_locale
  end
end
