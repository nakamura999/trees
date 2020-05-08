class UsersController < ApplicationController

  def show
  end

  def edit
  end

  def withdraw
  end

  def update
  end

  def user_destroy
  end

  private

    def user_params
      params.require(:user).permit(:name, :kana_name, :nickname, :prefectures, :status, :profile_image, :email)
    end

    def password_params
      params.require(:user).permit(:password, :password_confirmation, :current_password)
    end

end
