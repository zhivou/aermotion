class MyVideosController < ApplicationController
  def index
    @tutorials = WorkoutSet.where(type: 'tutorial')
  end
end
