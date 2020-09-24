class BoardsController < ApplicationController
  before_action :authenticate_user!

  layout 'styletops'

  def show
    @board = Board.find(params[:id])
    @board_comment = BoardComment.new
    # サイドバー
    @jenres = Jenre.all
    @tags = ActsAsTaggableOn::Tag.all
    @boards_new = Board.limit(5).order("created_at desc")
    @styels_new = Style.limit(12).order("created_at desc")
  end

  def index
    @boards = Board.all.order(created_at: :desc)
    @board = Board.new
    # サイドバー
    @jenres = Jenre.all
    @tags = ActsAsTaggableOn::Tag.all
    @boards_new = Board.limit(5).order("created_at desc")
    @styels_new = Style.limit(12).order("created_at desc")
  end

  def create
    @board = Board.new(board_params)
    @board.user_id = current_user.id
    if @board.save
      flash[:notice] = "投稿しました"
      redirect_to board_path(@board.id)
    else
      @boards = Board.all.order(created_at: :desc)
      @board = Board.new
      flash[:notice] = "投稿に失敗しました"
      render action: :index
    end
  end

  def destroy
    @board = Board.find(params[:id])
    @board.destroy
    flash[:notice] = "質問を削除しました"
    redirect_to boards_path
  end

  private

     def board_params
      params.require(:board).permit(:title, :content, :user_id)
     end

end
