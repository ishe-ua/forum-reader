# coding: utf-8
# Продолжение Position.
#
module Resource
  extend ActiveSupport::Concern

  protected

  ##
  # Get resource name from controller_name.
  #
  # Like 'accounts' => 'account'
  #

  def resource_name
    controller_name.singularize
  end

  ##
  # Get #resource plural name.
  #
  # Like 'account' => 'accounts'
  #

  def resource_plural_name
    controller_name
  end

  ##
  # Get resource instance variable from controller name.
  #
  # Like 'accounts' => @account
  #

  def resource
    instance_variable_get(('@' + resource_name).to_sym)
  end

  ## Get #resource class.
  def resource_class
    resource.class
  end

  ##
  # Set resource, method for <tt>before_action</tt>.
  #
  # Like AccountsContoller#set_account.
  #
  # <tt>Warninig:</tt> method should be defined in controller.
  #

  def set_resource
    instance_eval('set_' + resource_name)
  end
end
