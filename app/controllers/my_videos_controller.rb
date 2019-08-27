class MyVideosController < ApplicationController

  def index
    container = {}
    current_user.workout_sets.each do |set|
      container[set.title] = []
      set.media.each do |v|
        container[set.title] << rails_blob_path(v.video)
      end
    end
    gon.mediaSets = container
  end

  private
    def my_video_params
      params.fetch(:my_video, {})
    end
end
