class BoardsController < ApplicationController
  def show
  end

  def index
  end

  def create
  end

  private

     def board_params
      params.require(:board).permit(:title, :content, :user_id)
     end

end
