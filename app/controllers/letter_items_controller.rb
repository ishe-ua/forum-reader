# See LetterItem
class LetterItemsController < ApplicationController
  before_action :set_letter_item, only: %i(edit update destroy)
  include Mover

  def new
    @letter_item = LetterItem.new(letter_id: params[:letter_id])
  end

  def create
    @letter_item = LetterItem.new(letter_item_params)

    respond_to do |format|
      if @letter_item.save
        format.html { redirect_to data_path }
      else
        format.html { render :new }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @letter_item.update(letter_item_params)
        format.html { redirect_to data_path }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @resource = @letter_item
    @resource.destroy

    render 'shared/destroy'
  end

  private

  def set_letter_item
    @letter_item = if params[:letter_item]
                     current_user
                       .letters
                       .find(params[:letter_item][:letter_id])
                       .letter_items
                   else
                     LetterItem
                   end
                   .find(params[:id])
  end

  def letter_item_params
    params.require(:letter_item).permit(
      :letter_id,
      :name,
      :url
    )
  end
end
