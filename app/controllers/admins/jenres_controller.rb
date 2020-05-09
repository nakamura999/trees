class Admins::JenresController < ApplicationController

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
