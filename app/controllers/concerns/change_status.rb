# coding: utf-8
# Change Status.
#
module ChangeStatus
  extend ActiveSupport::Concern

  ## Patch, js request.
  def change_status
    @resource = controller_name.classify.constantize.find(params[:id])
    @resource.change_status

    render 'shared/change_status'
  end
end
