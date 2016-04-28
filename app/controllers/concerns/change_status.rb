# coding: utf-8
# Change Status.
#
module ChangeStatus
  extend ActiveSupport::Concern

  included do
  end

  def change_status
    @resource = controller_name.classify.constantize.find(:id)
    @resource.change_status
    render 'shared/change_status'
  end
end
