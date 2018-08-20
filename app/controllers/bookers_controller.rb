class BookersController < ApplicationController
  before_action :set_booker, only: [:show, :edit, :update, :destroy]

  # GET /bookers
  # GET /bookers.json
  def index
    @bookers = Booker.where('active IS NOT false').order(:land,:stadt,:club)
  end

  # GET /bookers/1
  # GET /bookers/1.json
  def show
    @booker = Booker.find(params[:id])
  end

  # GET /bookers/new
  def new
    @booker = Booker.new
  end

  # GET /bookers/1/edit
  def edit
  end

  # POST /bookers
  # POST /bookers.json
  def create
    @booker = Booker.new(booker_params_create)
    @booker.user_id = current_user.id
    respond_to do |format|
      if @booker.save
        format.html { redirect_to @booker, notice: 'Booker was successfully updated.' }
        format.json { render :show, status: :ok, location: @booker }
      else
        render_404
      end
    end
  end

  # PATCH/PUT /bookers/1
  # PATCH/PUT /bookers/1.json
  def update
    respond_to do |format|
      @booker = Booker.find(params[:id])
      @booker.user_id = current_user.id
      @booker.save_to_audit_before
      if @booker.update(booker_params_create)
        format.html { redirect_to @booker, notice: 'Booker was successfully updated.' }
        format.json { render :show, status: :ok, location: @booker }
      else
        format.html { render :edit }
        format.json { render json: @booker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookers/1
  # DELETE /bookers/1.json
  def destroy
    @booker.destroy
    respond_to do |format|
      format.html { redirect_to bookers_url, notice: 'Booker was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booker
      @booker = Booker.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booker_params_create
      params.permit(:stadt, :club, :email, :website, :homepage, :name, :telefon, :bundesland, :land, :plz, :active, :kommentar)
    end
    def booker_params
      params.fetch(:booker, {})
    end
end
