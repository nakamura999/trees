class StylesController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

    def style_params
      params.require(:style).permit(:name, :content, :price, :image, :jenre_id, :user_id)
    end

end
