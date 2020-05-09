class Admins::UsersController < ApplicationController

  layout 'admins'

  def show
  	@user = User.find(params[:id])
  end

  def index
  	@users = User.without_deleted
  	@user_deletes = User.only_deleted
  end
end
