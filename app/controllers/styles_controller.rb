class StylesController < ApplicationController
  def index
    if params[:tag]
      @styles = Style.tagged_with(params[:tag])
    else
      @styles = Style.all
    end
  end

  def show
    @style = Style.find(params[:id])
  end

  def new
    @style = Style.new
    @tags = ActsAsTaggableOn::Tag.all
  end

  def edit
    @style = Style.find(params[:id])
    @tags = ActsAsTaggableOn::Tag.all
  end

  def create
    @style = Style.new(style_params)
    @style.user_id = current_user.id
    @style.save
    redirect_to style_path(@style.id)
  end

  def update
    @style = Style.find(params[:id])
    @style.update(style_params)
    redirect_to style_path(@style.id)
  end

  def destroy
      @style = Style.find(params[:id])
      @style.destroy
      redirect_tob styles_path
  end

  private

    def style_params
      params.require(:style).permit(:name, :content, :price, :jenre_id, :user_id, :status, :menu, :color_style, :image, :image_second, :image_third, tag_list: [])
    end

end
