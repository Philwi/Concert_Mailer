class BandsController < ApplicationController
  before_action :logged_in
  def new
    @band = Band.new
  end

  def show
    @band = Band.where(user_id: current_user.id)
  end

  def index
    @band = Band.where(user_id: current_user.id)
  end

  def create
    @band = Band.new(band_params)
    @band.user_id = current_user.id
    if @band.save!
      redirect_to dashboard_path
    end
  end

  def edit
    @band = Band.find(params[:id])
  end

  def update
    @band = Band.find(band_params[:id])
    if @band.update(band_params)
      redirect_to dashboard_path
    end
  end

  def destroy
    @band = Band.find(params[:id])
    @band.destroy
    redirect_to dashboard_path
  end

  private
  def band_params
    params.require(:band).permit(:id,:name, :ort, :bandcamp, :website, :gründung, :email, :telefon, :event_color)
  end
  protected

  def logged_in
    redirect_to "/" unless user_signed_in?
  end

end
