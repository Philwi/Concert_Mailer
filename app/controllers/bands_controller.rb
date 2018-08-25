class BandsController < ApplicationController
  before_action :logged_in
  def new
    @band = Band.new
  end

  def show
    @band = Band.where("id IN (SELECT band_id FROM user_bands WHERE user_id = #{current_user.id})")
  end

  def index
    @band = Band.where("id IN (SELECT band_id FROM user_bands WHERE user_id = #{current_user.id})")
  end

  def create
    @band = Band.new(band_params)
    @band.user_id = current_user.id
    if @band.save!
      ub = UserBand.new(user_id: current_user.id, band_id: @band.id)
      ub.save
      redirect_to dashboard_path, flash: { notice: "Deine Band wurde erstellt" }
    else
      redirect_to dashboard_path, flash: { notice: "Deine Band konnte nicht erstellt werden" }
    end
  end

  def edit
    @band = Band.find(params[:id])
    @users = User.where("active IS NOT NULL OR active != false")
  end

  def update
    @band = Band.find(band_params[:id])
    if @band.update(band_params)
      redirect_to dashboard_path, flash: { notice: "Deine Band wurde geupdated" }
    else
      redirect_to dashboard_path, flash: { notice: "Deine Band konnte nicht geupdated werden" }
    end
  end

  def destroy
    @band = Band.find(params[:id])
    @band.destroy
    redirect_to dashboard_path
  end

  def share
    u = UserBand.new(user_id: params[:band_share][:user], band_id:  params[:band_share][:band_id])
    if u.save
      redirect_to dashboard_path, flash: { notice: "Band wurde geteilt" }
    else
      redirect_to dashboard_path, flash: { error: "Band konnte nicht geteilt werden" }
    end
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
