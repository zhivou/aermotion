class MyVideosController < ApplicationController

  before_action :get_media_per_user, only: [:index]

  def index
  end

  private
  ##
  # Returns data set for JS injection:
  # [{ title, type, video_url },{} ... {}]
  #
  def get_media_per_user
    container = []
    current_user.workout_sets.each do |set|
      hash = {}
      hash[:title] = set.title
      hash[:type] = Type.find(set.type_id).name
      hash[:video] = []
      set.media.each do |v|
        hash[:video] << rails_blob_path(v.video)
      end
      container << hash
    end
    gon.mediaSets = container
  end
end
