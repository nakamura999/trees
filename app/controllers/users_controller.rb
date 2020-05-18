class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @user_salons = @user.salons
    @user_styles = @user.styles
    # チャット機能
    @currentUserEntry = UserRoom.where(user_id: current_user.id)
    @userEntry = UserRoom.where(user_id: @user.id)

    # 自分のルーム一覧
    targetRoomIdList = UserRoom.select(:room_id).where(user_id: @user.id)
    @rooms = Room.where(id: targetRoomIdList)

    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isroom = true
            @roomid = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = UserRoom.new
      end
    end
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

          # <div class="col-xs-12">
          # <% @rooms.each do |room| %>
          #   <div class="box box-efect">
          #     <%= room.id %>
          #   </div>
          # <% end %>
          # </div>

  private

    def user_params
      params.require(:user).permit(:name, :kana_name, :nickname, :prefectures, :status, :profile_image, :email, :body)
    end

    def password_params
      params.require(:user).permit(:password, :password_confirmation, :current_password)
    end

end
