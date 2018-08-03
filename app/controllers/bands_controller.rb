class BandsController < ApplicationController
  def new
    @band = Band.new
  end

  def create
    @band = Band.new(band_params)
    @band.user_id = current_user.id
    if @band.save!
      redirect_to dashboard_path
    end
  end

  def edit
    @band = Band.where(user_id: current_user.id)
  end

  def update
    @band = Band.find(band_params[:id])
    if @band.update(band_params)
      redirect_to dashboard_path
    end
  end

  private
  def band_params
    params.require(:band).permit(:id,:name, :ort, :bandcamp, :website, :gründung, :email, :telefon)
  end

end
