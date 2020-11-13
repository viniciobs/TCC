require 'will_paginate/array'

class RatesController < ApplicationController
  before_action :set_rate, only: [:save]

  def save     
    @rate.value = params[:value]

    if @rate.value.nil?
      @rate.value = 0
    end

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

  def list           

    @songs = Song.where('user_id=?', current_user.id)
    @songs = @songs.filter_by_author(params[:author]) if params[:author].present?
    @songs = @songs.filter_by_name(params[:music]) if params[:music].present?

    @rates = Rate.where('song_id IN (?)', @songs.select(:id))

    @result = []

    @rates.each do |rate|
      item = @result.select { |result| result[:id] == rate.song_id }      
     
      if item.empty?
        song = Song.find(rate.song_id)
        @result << {id: rate.song_id, song: song.name, author: song.author, quantity: 1, value: rate.value.to_d }
      else
        item = item.first
        item[:quantity] += 1
        item[:value] += rate.value.to_d
      end
    end

    @result = @result.paginate(:page => params[:page], :per_page => 10)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rate
      @rate = Rate.find(params[:id]) if params[:id].present? 
      @rate = Rate.where('user_id=? AND song_id=?', params[:user_id], params[:song_id]).first if @rate.nil?
      
      @rate = Rate.new if @rate.nil?
      @rate.user_id = params[:user_id]
      @rate.song_id = params[:song_id]
    end

    # Only allow a list of trusted parameters through.
    def rate_params
      params.permit(:id, :song_id, :user_id, :value)
    end 
end
