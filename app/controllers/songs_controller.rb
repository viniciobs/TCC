class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy]
  before_action :check_specifc_permission, only: [:edit, :create, :new, :destroy]
  before_action :check_shared_permission, only: [:index, :show]

  # GET /songs
  # GET /songs.json
  def index    
    @songs = params[:musician].present? ? Song.where(user_id: params[:musician]) : Song.where(user_id: current_user.id)  
    @songs = @songs.order(:name)  
    @songs = @songs.filter_by_author(params[:author]) if params[:author].present?
    @songs = @songs.filter_by_name(params[:name]) if params[:name].present?
    @songs = @songs.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
  end

  # GET /songs/new
  def new
    @song = Song.new
  end

  # GET /songs/1/edit
  def edit
  end

  # POST /songs
  # POST /songs.json
  def create
    @song = Song.new(song_params)
    @song.user = current_user

    if exists @song.name, @song.author 
      respond_to do |format|
        flash.now[:notice] = "A música já está cadastrada para esta banda."
        format.html { render :edit }      
      end
      return
    end

    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice: 'A música foi adicionado com sucesso ao repertório.' }
        format.json { render :show, status: :created, location: @song }
      else
        format.html { render :new }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /songs/1
  # PATCH/PUT /songs/1.json
  def update

    if exists params[:name], params[:author]
      respond_to do |format|
        flash.now[:notice] = "A música já está cadastrada para esta banda."
        format.html { render :edit }      
      end
      return
    end

    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to @song, notice: 'A música foi atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song.destroy
    respond_to do |format|
      format.html { redirect_to songs_url, notice: 'A música foi removida com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def song_params
      params.require(:song).permit(:author, :name)
    end

    def exists name, author
      return Song.any?{|x| x.name == name && x.author == author && x.user_id == current_user.id }
    end

    def check_specifc_permission
      render_404 if !current_user.nil? && current_user.user_type != 'musician'
    end

    def check_shared_permission
      render_404 if !current_user.nil? && current_user.user_type == 'customer'
    end
end
