class Admins::TopAdminController < ApplicationController
  before_action :authenticate_admin!

  layout 'admins'

  def index
  	@users = User.all
  	@users_count = User.group_by_day(:created_at).size
    # @users_count = User.group_by_month(:created_at).size
  	@styles = Style.all
  	@styles_count = Style.group_by_day(:created_at).size
  	@boards = Board.all
  	@boards_count = Board.group_by_day(:created_at).size
  	@jenres_count = Jenre.joins(:styles).group(:name).size
  	@contact_count = Contact.group_by_day(:created_at).size
  	@contact_today = Contact.where(created_at: Date.today.all_day).count
  	@user_today = User.where(created_at: Date.today.all_day).count
  	@style_today = Style.where(created_at: Date.today.all_day).count
  	@board_today = Board.where(created_at: Date.today.all_day).count
  end
end
