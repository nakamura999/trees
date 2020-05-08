class SalonsController < ApplicationController
  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  private

    def salon_params
      params.require(:salon).permit(:salon_name, :salon_address, :salon_phone, :user_id, :salon_image)
    end

end
