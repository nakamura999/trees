class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @user_salons = @user.salons
    @user_styles = @user.styles
  end

  def edit
    @user = User.find(params[:id])
  end

  def withdraw
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "会員情報を変更しました"
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end

  private

    def user_params
      params.require(:user).permit(:name, :kana_name, :nickname, :prefectures, :status, :profile_image, :email, :body)
    end

    def password_params
      params.require(:user).permit(:password, :password_confirmation, :current_password)
    end

end
