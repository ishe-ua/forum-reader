# See Forum
class ForumsController < ApplicationController
  before_action :set_forum, only: %i[edit update destroy]
  include Mover

  def new
    @forum = current_user.forums.build
  end

  def create
    @forum = current_user.forums.build(forum_params)

    respond_to do |format|
      if @forum.save
        format.html { redirect_to data_path }
      else
        format.html { render :new }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @forum.update(forum_params)
        format.html { redirect_to data_path }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @resource = @forum
    @resource.destroy

    render 'shared/destroy'
  end

  private

  def set_forum
    @forum = current_user.forums.find(params[:id])
  end

  def forum_params
    params.require(:forum).permit(:name, :url, :target)
  end
end
