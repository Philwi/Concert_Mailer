class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :logged_in

  # GET /events
  # GET /events.json
  def index
    @events = Event.where("band_id IN (SELECT band_id FROM user_bands WHERE user_id = #{current_user.id})")
    # @events = Event.where(band_id: Band.where(user_id: current_user.id))
    @events = @events.where('start_time >= ? ', Time.zone.now).order("start_time")
    @band = Band.where("id IN (SELECT band_id FROM user_bands WHERE user_id = #{current_user.id})")
  end

  def search
    if params[:band_id].blank?
      @events = Event.where("band_id IN (SELECT band_id FROM user_bands WHERE user_id = #{current_user.id})")
      # @events = Event.where(band_id: Band.where(user_id: current_user.id))
      @events = @events.where('start_time >= ? ', Time.zone.now)
    else
      @events = Event.where('start_time >= ? AND band_id = ?', Time.zone.now, params[:band_id])
    end
    respond_to do |f|
      f.js
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  def calendar
    respond_to do |format|
      format.js
    end
  end

  # GET /events/new
  def new
    @event = Event.new
    @band = Band.where("id IN (SELECT band_id FROM user_bands WHERE user_id = #{current_user.id})")
  end

  # GET /events/1/edit
  def edit
    respond_to do |format|
      format.js
    end
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.band_id = params[:event][:band_id]
    if @event.save
      respond_to do |format|
        format.js {
          render 'calendar'
        }
      end
    end

    #respond_to do |format|
    #  if @event.save
    #    format.html { render 'calendar'}
    #    format.json { render :show, status: :created, location: @event }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @event.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    if @event.update(event_params)
      respond_to do |format|
        format.js {
          render 'calendar'
        }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :description, :start_time, :end_time, :location, :bands, :link)
    end
  protected
  def logged_in
    redirect_to "/" unless user_signed_in?
  end
end
