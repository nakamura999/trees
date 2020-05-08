class BoardCommentsController < ApplicationController
	def create
	end

	def destroy
    end

  private

     def board_comment_params
      params.require(:board_comment).permit(:comment)
     end

end
