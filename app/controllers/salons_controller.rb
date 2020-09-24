class SalonsController < ApplicationController
  before_action :authenticate_user!

  layout 'styletops'

  def new
    @salon = Salon.new
    # サイドバー
    @jenres = Jenre.all
    @tags = ActsAsTaggableOn::Tag.all
    @boards_new = Board.limit(5).order("created_at desc")
    @styels_new = Style.limit(12).order("created_at desc")
  end

  def edit
    @salon = Salon.find(params[:id])
    # サイドバー
    @jenres = Jenre.all
    @tags = ActsAsTaggableOn::Tag.all
    @boards_new = Board.limit(5).order("created_at desc")
    @styels_new = Style.limit(12).order("created_at desc")
    if @salon.user_id != current_user.id
      redirect_back(fallback_location: root_path)
    end
  end

  def create
    @salon = Salon.new(salon_params)
    @salon.user_id = current_user.id
    if @salon.save
        redirect_to user_path(current_user)
        flash[:notice] = "サロンを追加しました"
    else
        render :new
    end
  end

  def update
    @salon = Salon.find(params[:id])
    if @salon.update(salon_params)
        redirect_to user_path(current_user)
        flash[:notice] = "サロン情報変更しました"
    else
        render :edit
    end
  end

  def destroy
    @salon = Salon.find(params[:id])
    @salon.destroy
    redirect_to user_path(current_user)
    flash[:notice] = "サロンを一件削除しました"
  end

  private

    def salon_params
      params.require(:salon).permit(:salon_name, :salon_address, :salon_phone, :user_id, :salon_image)
    end

end
