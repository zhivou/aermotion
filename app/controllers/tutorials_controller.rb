class TutorialsController < ApplicationController
  def index
    @tutorials = WorkoutSet.where(type: 'Tutorial')
  end
end
