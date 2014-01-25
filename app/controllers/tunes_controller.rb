class TunesController < ApplicationController
  before_action :set_tune, only: [:show, :edit, :create, :update, :destroy, :new]

  # GET /tunes
  # GET /tunes.json
  def index
    set_artist
    # @artist = Artist.find(params[:artist_id])
    @tunes = @artist.tunes.all
  end

  # GET /tunes/1
  # GET /tunes/1.json
  def show
    set_tune
  end

  # GET /tunes/new
  def new
    set_artist
    @tune = @artist.tunes.build
  end
  def edit
    @artist = Artist.find(params[:artist_id])
    @tune = @artist.tunes.find(params[:id])
    @tune.name = params[:name]
    @tune.save
  end

  # POST /tunes
  # POST /tunes.json
  def create
    # set_tune
    set_artist
    # @tune = @artist.tunes.build(params[:tune])
    @tune = @artist.tunes.build(tune_params)

    respond_to do |format|
      if @tune.save
        format.html { redirect_to [@artist, @tune], notice: 'Tune was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tune }
      else
        format.html { render action: 'new' }
        format.json { render json: @tune.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tunes/1
  # PATCH/PUT /tunes/1.json
  def update
    respond_to do |format|
      if @tune.update(tune_params)
        format.html { redirect_to [@artist, @tune ], notice: 'Tune was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tune.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tunes/1
  # DELETE /tunes/1.json
  def destroy
    @tune.destroy
    respond_to do |format|
      format.html { redirect_to tunes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tune
      unless params[:id].present? 
        @tune = Tune.new
      else
        @tune = Tune.find(params[:id])
      end
    end
    def set_artist
      @artist = Artist.find(params[:artist_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def tune_params
      params.require(:tune).permit(:name)
    end
end
