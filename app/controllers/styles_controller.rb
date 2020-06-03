class StylesController < ApplicationController
  before_action :authenticate_user!, only:[:new, :edit, :create, :update, :destroy]

  def index
    @jenres = Jenre.all
    @tags = ActsAsTaggableOn::Tag.all
    if params[:tag]
      @styles = Style.tagged_with(params[:tag])
    elsif params[:status] == "MENS"
      @styles = Style.where(status: "MENS").order("RANDOM()").all
    elsif params[:status] == "LADIES"
      @styles = Style.where(status: "LADIES").order("RANDOM()").all
    elsif params[:jenre_id]
      @jenre = Jenre.find(params[:jenre_id])
      @styles = @jenre.styles.order("RANDOM()").all
    else
      @styles = Style.order("RANDOM()").all
    end
    # Mysql用(本番環境)
    # if params[:tag]
    #   @styles = Style.tagged_with(params[:tag])
    # elsif params[:status] == "MENS"
    #   @styles = Style.where(status: "MENS").order("RAND()").all
    # elsif params[:status] == "LADIES"
    #   @styles = Style.where(status: "LADIES").order("RAND()").all
    # elsif params[:jenre_id]
    #   @jenre = Jenre.find(params[:jenre_id])
    #   @styles = @jenre.styles.order("RAND()").all
    # else
    #   @styles = Style.order("RAND()").all
    # end
  end

  def show
    @style = Style.find(params[:id])
    @user_styles = @style.user.styles
  end

  def new
    @style = Style.new
    @tags = ActsAsTaggableOn::Tag.all
  end

  def edit
    @style = Style.find(params[:id])
    @tags = ActsAsTaggableOn::Tag.all
    if @style.user_id != current_user.id
      redirect_back(fallback_location: root_path)
    end
  end

  def create
    @style = Style.new(style_params)
    @style.user_id = current_user.id
    if @style.save
      flash[:notice] = "スタイルを登録しました"
      redirect_to style_path(@style.id)
    else
      @tags = ActsAsTaggableOn::Tag.all
      render :new
    end
  end

  def update
    @style = Style.find(params[:id])
    if @style.update(style_params)
      flash[:notice] = "スタイルを更新しました"
      redirect_to style_path(@style.id)
    else
      @tags = ActsAsTaggableOn::Tag.all
      render :edit
    end
  end

  def destroy
      @style = Style.find(params[:id])
      @style.destroy
      redirect_to user_path(current_user.id)
  end

  private

    def style_params
      params.require(:style).permit(:name, :content, :price, :jenre_id, :user_id, :status, :menu, :color_style, :image, :image_second, :image_third, tag_list: [])
    end

end
