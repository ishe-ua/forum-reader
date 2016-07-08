# Static pages.
#
# All of them are Auth#require_sign_in by default.
#
class PagesController < ApplicationController
  skip_before_action :require_sign_in,
                     only: [:home, :help, :info]

  # Start page. Redirect to #data if signed.
  def home
    redirect_to data_path if signed_in?
  end

  # Help page.
  def help
  end

  # Show +flash+ messages or redirect to #home if empty.
  def info
    redirect_to(root_path) if flash.notice.blank? && flash.alert.blank?
  end

  # Start page for signed in.
  def data
  end
end
