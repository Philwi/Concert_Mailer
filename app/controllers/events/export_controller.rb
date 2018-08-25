class Events::ExportController < ApplicationController
  def show
    @bands = Band.where("id IN (SELECT band_id FROM user_bands WHERE user_id = #{current_user.id})")
  end

  def export_and_send
    if params[:export][:events].blank?
      @events = Event.where("band_id IN (SELECT band_id FROM user_bands WHERE user_id = #{current_user.id}) AND start_time >= ? ", Time.zone.now)
    else
      @events = Event.where("band_id IN (SELECT band_id FROM user_bands WHERE user_id = #{current_user.id}) AND band_id = #{params[:export][:events]} AND start_time >= ? ", Time.zone.now)
    end
    if EventMailer.send_events(@events, current_user).deliver_now
      redirect_to dashboard_path, flash: { notice: "Events wurden verschickt" }
    else
      redirect_to dashboard_path, flash: { error: "Die Events konnten nicht verschickt werden..." }
    end
  end
end
