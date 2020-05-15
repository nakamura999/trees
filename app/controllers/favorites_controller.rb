class FavoritesController < ApplicationController

	def create
		@style = Style.find(params[:style_id])
		favorite = @style.favorites.new(user_id: current_user.id)
		favorite.save
		redirect_to style_path(@style.id)
	end

	def destroy
		@style = Style.find(params[:style_id])
		favorite = current_user.favorites.find_by(style_id: @style.id)
		favorite.destroy
		redirect_to style_path(@style.id)
	end

end
