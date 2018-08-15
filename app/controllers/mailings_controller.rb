class MailingsController < ApplicationController
  before_action :set_mailing, only: [:show, :edit, :update, :destroy]

  # GET /mailings
  # GET /mailings.json
  def index
    @bookers = Booker.where('email IS NOT NULL').order(:land,:stadt,:club)
  end

  def mailing
    @mailing = Mailing.new(mailing_params)
    @mailing.user_id = current_user.id
    if @mailing.save && !params[:band].blank?
      mailing_params[:veranstalter].split(',').each do |mail|
        BookingMailer.with(user: current_user, veranstalter: Booker.find(mail), mail: @mailing, band: params[:band] ).gig_mail.deliver_now
      end
    else
      render_404
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mailing
      @mailing = Mailing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mailing_params
      params.permit(:subject, :body, :veranstalter)
    end
end
