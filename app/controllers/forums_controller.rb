# coding: utf-8
# Морда для Forum.
#
class ForumsController < ApplicationController
  before_action :set_forum, only:
                              [
                                :edit,
                                :update,
                                :move_up,
                                :move_down,
                                :destroy
                              ]

  ##
  # GET /forums/new
  #
  # Создать новый.
  #

  def new
    @forum = current_user.forums.build
  end

  ##
  # POST /forums
  #
  # Создать.
  #

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

  ##
  # GET /forums/1/edit
  #
  # Показать страницу редактирования.
  #

  def edit
  end

  ##
  # PATCH/PUT /forums/1
  #
  # Обновить.
  #

  def update
    respond_to do |format|
      if @forum.update(forum_params)
        format.html { redirect_to data_path }
      else
        format.html { render :edit }
      end
    end
  end

  ## Поднять выше в списке.
  def move_up
    Forum.transaction do
      @forum.move_higher
    end
  end

  ## Опустить ниже в списке.
  def move_down
    Forum.transaction do
      @forum.move_lower
    end
  end

  ##
  # DELETE /forums/1.js
  #
  # Удалить.
  #

  def destroy
    @forum.destroy
  end

  private

  def set_forum
    @forum = current_user.forums.find(params[:id])
  end

  def forum_params
    params.require(:forum).permit(:name, :url, :target)
  end
end
