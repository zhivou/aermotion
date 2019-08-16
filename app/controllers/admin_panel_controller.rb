class AdminPanelController < ApplicationController
  def index
    @workout_sets = WorkoutSet.all
  end
end
