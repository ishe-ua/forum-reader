# coding: utf-8
# Проверка Account -а.
#
module CheckAccount
  extend ActiveSupport::Concern

  ## Проверка уже была или нет? Ключ в session.
  ACCOUNT_CHECK_SESSION_KEY = 'account_checked'.freeze

  ## Страницы, доступ к которым без проверки аккаунта запрещен.
  DEPRICATED_PAGES_WITHOUT_CHECK_ACCOUNT = [
    %w(pages data)
  ].freeze

  included do
    before_action :check_models_presence
    before_action :check_account_filling
  end

  protected

  ## Запрещенная без заполнения аккаунта страница или нет?
  def depricated_page?
    b = false
    DEPRICATED_PAGES_WITHOUT_CHECK_ACCOUNT.each do |page|
      b = true if controller_name == page[0] && action_name == page[1]
    end
    b
  end

  ##
  # Проверить наличие обязательных моделей и посоздавать их если надо.
  #
  # <tt>Увага:</tt> метод обязательно должен идти перед
  # #check_account_filling.
  #

  def check_models_presence
    return unless depricated_page?
    key = ACCOUNT_CHECK_SESSION_KEY

    if signed_in? && session[key].blank?
      create_user_if_absent
      create_reader_set_if_absent
      create_mailer_set_if_absent
    end
  end

  ##
  # Проверить заполнение обязательных полей и отправить если надо на
  # дозаполнение.
  #

  def check_account_filling
    return unless depricated_page?
    key = ACCOUNT_CHECK_SESSION_KEY

    if request.get? &&
       signed_in? &&
       current_user.valid? &&
       current_account.valid?

      session[key] = true
    else
      redirect_to sets_path
    end
  end

  private

  def create_user_if_absent
    if current_account.user.nil?
      user = current_account.build_user
      user.save!(validate: false)
    end
  end

  def create_reader_set_if_absent
    if current_user.reader_set.nil?
      reader_set = current_user.build_reader_set
      reader_set.save!(validate: false)
    end
  end

  def create_mailer_set_if_absent
    if current_user.mailer_set.nil?
      mailer_set = current_user.build_mailer_set
      mailer_set.save!(validate: false)
    end
  end
end
