class AdminPanelController < ApplicationController
  def index
    @users = User.all
    @workouts = WorkoutSet.all
    @videos = Medium.all
  end

  def add_video
    @workouts = WorkoutSet.all
  end

  def add_user
  end
end
