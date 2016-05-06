# coding: utf-8
# Сбросить пароль.
#
# Консерва AccountsController.
#
module ResetPassword
  extend ActiveSupport::Concern

  included do
    skip_before_action :require_sign_in, only: :reset_password
  end

  ##
  # Обработчик GET и POST.
  #
  # Выставляем новый случайный и шлем его пиплу на почту.
  # Помогает Password#generate_random_password.
  #

  def reset_password
    reset_password_get  if request.get?
    reset_password_post if request.post?
    nil
  end

  protected

  ##
  # GET /accounts/reset_password
  # Показать форму ввода email и каптчи.
  #

  def reset_password_get
    render 'reset_password'
  end

  ##
  # POST /accounts/reset_password
  # Сбросить текущий пароль и выслать новый на email.
  #
  # AccountsMailer#new_password
  #

  def reset_password_post
    account = Account.find_by(email: params[:email])

    if account
      generate_new_and_send_email(account)
      flash.notice = t 'we_sent_you_email'
    else
      flash.alert = t 'reset_password.fail'
    end

    redirect_to info_path
  end

  private

  def generate_new_and_send_email(account)
    new_passwd = Account.generate_random_password
    account.update!(password: new_passwd, password_confirmation: new_passwd)

    AccountsMailer
      .new_password(account, new_passwd)
      .deliver_later(queue_priority: 0)
  end
end
