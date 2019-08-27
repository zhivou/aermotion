class MyVideosController < ApplicationController

  before_action :get_media_per_user, only: [:index]

  def index
  end

  private
  ##
  # Returns data set for JS injection:
  # [{ id, title, type, video_url },{} ... {}]
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
end
