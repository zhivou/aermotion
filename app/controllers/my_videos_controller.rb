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
    container = []
    current_user.workout_sets.each do |set|
      hash = {}
      hash[:id] = set.id
      hash[:title] = set.title
      hash[:type] = Type.find(set.type_id).name
      hash[:videos] = []
      set.media.each do |v|
        videos_hash = {}
        videos_hash[:id] = v.id
        videos_hash[:name] = v.title
        videos_hash[:url] = rails_blob_path(v.video)
        hash[:videos] << videos_hash
      end
      container << hash
    end
    gon.mediaSets = container
  end
end
