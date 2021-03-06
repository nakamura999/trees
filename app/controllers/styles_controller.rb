class StylesController < ApplicationController
  before_action :authenticate_user!, only:[:new, :edit, :create, :update, :destroy]

  layout 'styletops'

  def index
    @jenres = Jenre.all
    @tags = ActsAsTaggableOn::Tag.all
    @boards_new = Board.limit(5).order("created_at desc")
    @styels_new = Style.limit(12).order("created_at desc")

    # ソート
    @created_at = '投稿順▲'
    @created_at_num = 0

    if user_signed_in?
      @user = current_user.favorites_styles
      @user_favorites = @user.limit(5).order("created_at desc")
    end

    if params[:created_at] && params[:tag]
      # ソート機能(タグ)
      @created_at_num = params[:created_at].to_i
      @style_tag = Style.tagged_with(params[:tag])
      if @created_at_num == 2
        # タグ古い順
        @rank = Style.joins(:favorites).group("favorites.style_id").where(id: @style_tag).order('count(style_id) desc').limit(5)
        @style_tag = Style.tagged_with(params[:tag])
        @styles = @style_tag.order("created_at asc").all.page(params[:page]).per(30)
        @created_at = '投稿順▼'
        @created_at_num = 3
      else
        # タグ新着順
        @rank = Style.joins(:favorites).group("favorites.style_id").where(id: @style_tag).order('count(style_id) desc').limit(5)
        @style_tag = Style.tagged_with(params[:tag])
        @styles = @style_tag.order("created_at desc").all.page(params[:page]).per(30)
        @created_at = '新着順▲'
        @created_at_num = 2
      end
    elsif params[:tag]
    # タグ検索
      @created_at_num = 2
      @style_tag = Style.tagged_with(params[:tag])
      @styles = @style_tag.order("created_at desc").all.page(params[:page]).per(30)
      @rank = Style.joins(:favorites).group("favorites.style_id").where(id: @style_tag).order('count(style_id) desc').limit(5)
    elsif params[:status] == "MENS"
    # メンズ検索
      @created_at_num = 4
      @styles = Style.where(status: "MENS").order("created_at desc").all.page(params[:page]).per(30)
      @rank = Style.joins(:favorites).group("favorites.style_id").where(status: "MENS").order('count(style_id) desc').limit(5)
    elsif params[:status] == "LADIES"
    # レディース検索
      @created_at_num = 6
      @styles = Style.where(status: "LADIES").order("created_at desc").all.page(params[:page]).per(30)
      @rank = Style.joins(:favorites).group("favorites.style_id").where(status: "LADIES").order('count(style_id) desc').limit(5)
    elsif params[:created_at] && params[:jenre_id]
    # ソート機能(ジャンル)
      @created_at_num = params[:created_at].to_i
      @jenre = Jenre.find(params[:jenre_id])
      if @created_at_num == 8
        # ジャンル古い順
        @styles = @jenre.styles.order("created_at asc").all.page(params[:page]).per(30)
        @rank = Style.joins(:favorites).group("favorites.style_id").where(jenre_id: @jenre.id).order('count(style_id) desc').limit(5)
        @created_at = '投稿順▼'
        @created_at_num = 9
      else
        # レディース新着順
        @styles = @jenre.styles.order("created_at desc").all.page(params[:page]).per(30)
        @rank = Style.joins(:favorites).group("favorites.style_id").where(jenre_id: @jenre.id).order('count(style_id) desc').limit(5)
        @created_at = '新着順▲'
        @created_at_num = 8
      end
    elsif params[:jenre_id]
    # ジャンル検索
      @created_at_num = 8
      @jenre = Jenre.find(params[:jenre_id])
      @styles = @jenre.styles.order("created_at desc").all.page(params[:page]).per(30)
      @rank = Style.joins(:favorites).group("favorites.style_id").where(jenre_id: @jenre.id).order('count(style_id) desc').limit(5)
    elsif params[:search]
    # スタイリスト名 &　都道府県検索
      @styles_search = Style.search(params[:search])
      @styles = @styles_search.order("created_at desc").all.page(params[:page]).per(30)
      @rank = Style.joins(:favorites).group("favorites.style_id").where(id: @styles_search).order('count(style_id) desc').limit(5)
    elsif params[:created_at]
    # ソート機能
      @created_at_num = params[:created_at].to_i

      if @created_at_num == 0
        @rank = Style.find(Favorite.group(:style_id).order('count(style_id) desc').limit(5).pluck(:style_id))
        @styles = Style.order("created_at asc").all.page(params[:page]).per(30)
        @created_at = '新着順▲'
        @created_at_num = 1
      elsif @created_at_num == 4
        # メンズ古い順
        @rank = Style.joins(:favorites).group("favorites.style_id").where(status: "MENS").order('count(style_id) desc').limit(5)
        @styles = Style.where(status: "MENS").order("created_at asc").all.page(params[:page]).per(30)
        @created_at = '投稿順▼'
        @created_at_num = 5
      elsif @created_at_num == 5
        # メンズ新着順
        @rank = Style.joins(:favorites).group("favorites.style_id").where(status: "MENS").order('count(style_id) desc').limit(5)
        @styles = Style.where(status: "MENS").order("created_at desc").all.page(params[:page]).per(30)
        @created_at = '新着順▲'
        @created_at_num = 4
      elsif @created_at_num == 6
        # レディース古い順
        @rank = Style.joins(:favorites).group("favorites.style_id").where(status: "LADIES").order('count(style_id) desc').limit(5)
        @styles = Style.where(status: "LADIES").order("created_at asc").all.page(params[:page]).per(30)
        @created_at = '投稿順▼'
        @created_at_num = 7
      elsif @created_at_num == 7
        # レディース新着順
        @rank = Style.joins(:favorites).group("favorites.style_id").where(status: "LADIES").order('count(style_id) desc').limit(5)
        @styles = Style.where(status: "LADIES").order("created_at desc").all.page(params[:page]).per(30)
        @created_at = '新着順▲'
        @created_at_num = 6
      else
        @rank = Style.find(Favorite.group(:style_id).order('count(style_id) desc').limit(5).pluck(:style_id))
        @styles = Style.order("created_at desc").all.page(params[:page]).per(30)
        @created_at = '投稿順▼'
        @created_at_num = 0
      end
    else
      @styles = Style.order("created_at desc").all.page(params[:page]).per(30)
      @rank = Style.find(Favorite.group(:style_id).order('count(style_id) desc').limit(5).pluck(:style_id))
    end
    # 以前のデータ
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
    #   @rank = Style.find(Favorite.group(:style_id).order('count(style_id) desc').limit(5).pluck(:style_id))
    # end
  end

  def show
    @style = Style.find(params[:id])
    @user_styles = @style.user.styles
    @jenres = Jenre.all
    @tags = ActsAsTaggableOn::Tag.all
    @boards_new = Board.limit(5).order("created_at desc")
    @styels_new = Style.limit(12).order("created_at desc")
  end

  def new
    @style = Style.new
    @tags = ActsAsTaggableOn::Tag.all
    @jenres = Jenre.all
    @boards_new = Board.limit(5).order("created_at desc")
    @styels_new = Style.limit(12).order("created_at desc")
  end

  def edit
    @style = Style.find(params[:id])
    @tags = ActsAsTaggableOn::Tag.all
    @jenres = Jenre.all
    @boards_new = Board.limit(5).order("created_at desc")
    @styels_new = Style.limit(12).order("created_at desc")
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
