# See Letter
class LettersController < ApplicationController
  before_action :set_letter, only: %i[edit update destroy]
  include Mover

  def new
    @letter = current_user.letters.build
  end

  def create
    @letter = current_user.letters.build(letter_params)

    respond_to do |format|
      if @letter.save
        format.html { redirect_to data_path }
      else
        format.html { render :new }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @letter.update(letter_params)
        format.html { redirect_to data_path }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @resource = @letter
    @resource.destroy

    render 'shared/destroy'
  end

  private

  def set_letter
    @letter = current_user.letters.find(params[:id])
  end

  def letter_params
    params.require(:letter).permit(
      :name,
      :d1, :d2, :d3, :d4, :d5, :d6, :d7,
      :hour,
      :minute
    )
  end
end
