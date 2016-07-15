# Concern for ApplicationController
#
module TrackLocale
  extend ActiveSupport::Concern

  included do
    before_action :track_locale
  end

  protected

  ## Set locale from session
  def track_locale
    I18n.locale = session[:current_locale] || I18n.default_locale
  end
end
