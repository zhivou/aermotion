class MyVideosController < ApplicationController

  before_action :authenticate_user!
  before_action :get_media_per_user_single, only: [:show]

  def index
    @workouts = current_user.workout_sets
  end

  def show
    @workout = current_user.workout_sets.find(params[:id])
  end

  private
  ##
  # Returns playlist for videoJS player:
  # All in one
  #
  def get_media_per_user
    playlist_array = []
    current_user.workout_sets.each do |set|
      set.media.each do |v|
        sources_array = []
        videos_hash = {}
        sources_array << {
            src: rails_blob_path(v.video),
            type: 'video/mp4'
        }
        videos_hash[:name] = v.title
        videos_hash[:sources] = sources_array
        playlist_array << videos_hash
      end
    end
    gon.mediaSets = playlist_array
  end

  ##
  # Returns playlist for one workout set
  #
  def get_media_per_user_single
    playlist_array = []
    current_user.workout_sets.find(params[:id]).media.each do |v|
      sources_array = []
      videos_hash = {}
      sources_array << {
          src: rails_blob_path(v.video),
          type: 'video/mp4'
      }
      videos_hash[:name] = v.title
      videos_hash[:sources] = sources_array
      playlist_array << videos_hash
    end
    gon.mediaSets = playlist_array
  end
end
