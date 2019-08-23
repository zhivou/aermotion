class MyVideosController < ApplicationController

  def index
  end

  private
    def my_video_params
      params.fetch(:my_video, {})
    end
end
