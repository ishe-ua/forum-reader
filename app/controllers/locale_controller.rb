# See Locale
class LocaleController < ApplicationController
  skip_before_action :require_sign_in

  # Change current locale
  def change
    session[:current_locale] = params[:lang]
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end
end
