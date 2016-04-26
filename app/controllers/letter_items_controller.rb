# coding: utf-8
# Морда для LetterItem.
#
class LetterItemsController < ApplicationController
  before_action :set_letter_item, only: [:edit, :update, :destroy]
  include Mover

  ## Новый.
  def new
    @letter_item = LetterItem.new(params[:letter_id])
  end

  ## Создать.
  def create
    @letter_item = current_user.letters.find(params[:letter_id])
                               .build(letter_item_params)

    respond_to do |format|
      if @letter_item.save
        format.html { redirect_to data_path }
      else
        format.html { render :new }
      end
    end
  end

  ## Страница редактирования.
  def edit
  end

  ## Обновить.
  def update
    respond_to do |format|
      if @letter_item.update(letter_item_params)
        format.html { redirect_to data_path }
      else
        format.html { render :edit }
      end
    end
  end

  ##
  # DELETE /letter_items/1.js
  #
  # Удалить.
  #

  def destroy
    @letter_item.destroy
  end

  private

  def set_letter_item
    @letter_item = current_user.letters.find(params[:letter_id])
                               .find(params[:id])
  end

  def letter_item_params
    params.require(:letter_item).permit(
      :name,
      :url
    )
  end
end
