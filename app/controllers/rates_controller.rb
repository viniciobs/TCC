class RatesController < ApplicationController
  before_action :set_rate, only: [:save]

  def save
   @rate.user_id = params[:user_id]
   @rate.song_id = params[:song_id]
   @rate.value = params[:value]   

    if @rate.save 
      render :json => @rate, :status => :created
    else
      render :json => @rate, :status => :unprocessable_entity
    end
  end

  # GET /rates
  # GET /rates.json
  def index    
    @artists = User.where('active=? AND user_type=? AND scheduled_today=?', true, 1, true)
    @scheduled_artist = @artists.first
   
    @songs = Song.where('user_id IN (?)', @artists.select(:id))
    @songs = @songs.filter_by_author(params[:author]) if params[:author].present?
    @songs = @songs.filter_by_name(params[:music]) if params[:music].present?
    @songs = @songs.paginate(:page => params[:page], :per_page => 10)
    
    @rates = Rate.where('user_id=?', current_user.id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rate
      @rate = params[:id].present? ? Rate.find(params[:id]) : Rate.new
    end

    # Only allow a list of trusted parameters through.
    def rate_params
      params.permit(:id, :song_id, :user_id, :value)
    end
end
