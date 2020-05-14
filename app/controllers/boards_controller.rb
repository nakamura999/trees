class BoardsController < ApplicationController
  def show
    @board = Board.find(params[:id])
    @board_comment = BoardComment.new
  end

  def index
    @boards = Board.all.order(created_at: :desc)
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    @board.user_id = current_user.id
    if @board.save
      redirect_to board_path(@board.id)
    else
      @boards = Board.all.order(created_at: :desc)
      @board = Board.new
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
