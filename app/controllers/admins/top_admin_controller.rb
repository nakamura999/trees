class Admins::TopAdminController < ApplicationController
  before_action :authenticate_admin!

  layout 'admins'

  def index
  	@users_count = User.group_by_day(:created_at).size
  end
end
