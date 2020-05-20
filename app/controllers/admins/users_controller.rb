class Admins::UsersController < ApplicationController
  before_action :authenticate_admin!

  layout 'admins'

  def show
  	@user = User.find(params[:id])
  end

  def index
  	if params[:search]
  	  @users = User.without_deleted.search(params[:search])
  	else
  	  @users = User.without_deleted
  	 end
  	@user_deletes = User.only_deleted
  end

  def destroy
  	@user = User.find(params[:id])
  	@user.destroy
  	flash[:notice] = "会員を削除しました"
  	redirect_to admins_users_path
  end

end
