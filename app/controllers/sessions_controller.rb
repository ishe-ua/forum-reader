# Sign in/out.
#
# See Auth
#
class SessionsController < ApplicationController
  before_action :downcase_email, only: :create
  skip_before_action :require_sign_in, except: :destroy

  def new
    redirect_to(root_path) if signed_in?
  end

  # Params:
  #
  # * <tt>params[:email]</tt>
  # * <tt>params[:password]</tt>
  #
  # Return:
  #
  # * <tt>flash[:alert]</tt> Error if need
  #
  def create
    b = sign_in(params[:email], params[:password])
    if b == true
      url = defined?(BackUrl) ? (back_url || root_path) : root_path
      redirect_to url
    else
      flash.alert = b
      render :new
    end
  end

  def destroy
    sign_out if signed_in?
    redirect_to root_path
  end

  protected

  def downcase_email
    params[:email].downcase! if params[:email].present?
  end
end
