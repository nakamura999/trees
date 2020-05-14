class BoardCommentsController < ApplicationController
	def create
		@board = Board.find(params[:board_id])
		@board_comment = @board.board_comments.new(board_comment_params)
		@board_comment.user_id = current_user.id
		@board_comment.save
		redirect_to board_path(@board.id)
	end

	def destroy
		@board_comment = BoardComment.find(params[:board_id])
		@board_comment.destroy
		redirect_to board_path(@board_comment.board.id)
    end

  private

     def board_comment_params
      params.require(:board_comment).permit(:comment)
     end

end
