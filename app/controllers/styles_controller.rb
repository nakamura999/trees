class StylesController < ApplicationController
  before_action :authenticate_user!, only:[:new, :edit, :create, :update, :destroy]

  layout 'styletops'

  def index
    @jenres = Jenre.all
    @tags = ActsAsTaggableOn::Tag.all
    @boards_new = Board.limit(5).order("created_at desc")
    @styels_new = Style.limit(12).order("created_at desc")
    if params[:tag]
      @styles = Style.tagged_with(params[:tag])
      @rank = Style.joins(:favorites).group("favorites.style_id").where(id: @styles).order('count(style_id) desc').limit(5)
    elsif params[:status] == "MENS"
      @styles = Style.where(status: "MENS").order("RANDOM()").all
      @rank = Style.joins(:favorites).group("favorites.style_id").where(status: "MENS").order('count(style_id) desc').limit(5)
    elsif params[:status] == "LADIES"
      @styles = Style.where(status: "LADIES").order("RANDOM()").all
      @rank = Style.joins(:favorites).group("favorites.style_id").where(status: "LADIES").order('count(style_id) desc').limit(5)
    elsif params[:jenre_id]
      @jenre = Jenre.find(params[:jenre_id])
      @styles = @jenre.styles.order("RANDOM()").all
      @rank = Style.joins(:favorites).group("favorites.style_id").where(jenre_id: @jenre.id).order('count(style_id) desc').limit(5)
    elsif params[:search]
      @styles = Style.search(params[:search])
      @rank = Style.joins(:favorites).group("favorites.style_id").where(id: @styles).order('count(style_id) desc').limit(5)
    else
      @styles = Style.order("RANDOM()").all
      @rank = Style.find(Favorite.group(:style_id).order('count(style_id) desc').limit(5).pluck(:style_id))
    end
    # Mysql用(本番環境)
    # if params[:tag]
    #   @styles = Style.tagged_with(params[:tag])
    #   @rank = Style.joins(:favorites).group("favorites.style_id").where(id: @styles).order('count(style_id) desc').limit(5)
    # elsif params[:status] == "MENS"
    #   @styles = Style.where(status: "MENS").order("RAND()").all
    #   @rank = Style.joins(:favorites).group("favorites.style_id").where(status: "MENS").order('count(style_id) desc').limit(5)
    # elsif params[:status] == "LADIES"
    #   @styles = Style.where(status: "LADIES").order("RAND()").all
    #   @rank = Style.joins(:favorites).group("favorites.style_id").where(status: "LADIES").order('count(style_id) desc').limit(5)
    # elsif params[:jenre_id]
    #   @jenre = Jenre.find(params[:jenre_id])
    #   @styles = @jenre.styles.order("RAND()").all
    #   @rank = Style.joins(:favorites).group("favorites.style_id").where(jenre_id: @jenre.id).order('count(style_id) desc').limit(5)
    # elsif params[:search]
    #   @styles = Style.search(params[:search])
    #   @rank = Style.joins(:favorites).group("favorites.style_id").where(id: @styles).order('count(style_id) desc').limit(5)
    # else
    #   @styles = Style.order("RAND()").all
    #   @rank = Style.find(Favorite.group(:style_id).order('count(style_id) desc').limit(3).pluck(:style_id))
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
