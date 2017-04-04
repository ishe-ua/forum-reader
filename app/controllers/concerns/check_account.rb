# See Account
module CheckAccount
  extend ActiveSupport::Concern

  # Pages with deprecated access without check
  DEPRICATED_PAGES_WITHOUT_CHECK_ACCOUNT = [%w[pages data]].freeze

  included do
    before_action :check_models_presence
    before_action :check_account_filling
  end

  protected

  # Deprecated without Account filling page or not?
  def depricated_page?
    b = false
    DEPRICATED_PAGES_WITHOUT_CHECK_ACCOUNT.each do |page|
      b = true if controller_name == page[0] && action_name == page[1]
    end
    b
  end

  # Check availability of required fields and create them if need.
  #
  # <tt>WARN:</tt> necessarily should be before #check_account_filling.
  def check_models_presence
    return unless depricated_page?
    return unless signed_in? && !current_user

    create_user_if_absent
    create_reader_set_if_absent
    create_mailer_set_if_absent
  end

  # Check filling of required fields and send to afterfilling if need
  def check_account_filling
    return unless depricated_page?

    redirect_to edit_account_path(current_account) unless
      request.get? &&
      current_user&.valid? &&
      current_account&.valid?
  end

  private

  def create_user_if_absent
    return if current_account.user
    user = current_account.build_user
    user.save!(validate: false)
  end

  def create_reader_set_if_absent
    return if current_user.reader_set
    reader_set = current_user.build_reader_set
    reader_set.save!(validate: false)
  end

  def create_mailer_set_if_absent
    return if current_user.mailer_set
    mailer_set = current_user.build_mailer_set
    mailer_set.save!(validate: false)
  end
end
