class ArtistSuggestionController < ApplicationController
  before_action :set_suggestion, only: [:destroy]

  def index    
    isMusician = current_user.user_type == 'musician'  

    @suggestions =  ArtistSuggestion.where(target_id: current_user.id) if isMusician
    @suggestions = ArtistSuggestion.where(user_id: current_user.id) if !isMusician
    @suggestions = @suggestions.paginate(:page => params[:page], :per_page => 10) 

    if isMusician
      @suggestions.each do |suggestion|
        suggestion.seen = true
        suggestion.save
      end
    end
  end

  def create  	
  	@artist_suggestion = ArtistSuggestion.new
  	@artist_suggestion.user_id = current_user.id
  	@artist_suggestion.target_id = User.where(scheduled_today: true).first.id
  	@artist_suggestion.text = params[:text]

    respond_to do |format|      
      	message = @artist_suggestion.save ? 'Sugestão enviada com sucesso.' : 'Ocorreu um erro ao enviar a sugestão'
        format.html { redirect_to rates_path, notice: message }
        format.json { render :index }      
    end
  end

  def destroy    
    @suggestion.delete
     
    respond_to do |format|
      format.html { redirect_to artist_suggestion_path, notice: 'Sugestão removida com sucesso.' }
      format.json { head :no_content }
    end
  end
  
  private

  def set_suggestion
    @suggestion = ArtistSuggestion.find(params[:id])
  end

end
