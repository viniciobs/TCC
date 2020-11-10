class ArtistSuggestionController < ApplicationController

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
  
end
