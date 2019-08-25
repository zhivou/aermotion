class MyVideosController < ApplicationController

  def index
    @workouts = current_user.workout_sets
  end

  private
    def my_video_params
      params.fetch(:my_video, {})
    end
end
