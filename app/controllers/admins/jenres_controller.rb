class Admins::JenresController < ApplicationController
  before_action :authenticate_admin!

  layout 'admins'

  def index
    @jenre = Jenre.new
    @jenres = Jenre.all
  end

  def edit
    @jenre = Jenre.find(params[:id])
  end

  def create
    @jenre = Jenre.new(jenre_params)
      if @jenre.save
        redirect_to admins_jenres_path
        flash[:notice] = "ジャンルを追加しました"
      else
        @jenre = Jenre.new
        @jenres = Jenre.all
        flash[:notice] = "ジャンルは1文字以上20文字以内です"
        render :index
      end
  end

  def update
    @jenre = Jenre.find(params[:id])
    if @jenre.update(jenre_params)
        redirect_to admins_jenres_path
        flash[:notice] = "ジャンルを変更しました"
    else
        render :edit
    end
  end

  private

  def jenre_params
    params.require(:jenre).permit(:name)
  end

end
