class Admins::GenresController < ApplicationController
  def index
  end

  def edit
  end

  def create
  end

  def update
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
