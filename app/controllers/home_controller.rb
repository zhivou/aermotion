class HomeController < ApplicationController
  def index
    @workout_sets = WorkoutSet.order("created_at desc").includes(:type).limit(6)
  end
end
