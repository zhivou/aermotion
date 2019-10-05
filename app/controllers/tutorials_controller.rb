class TutorialsController < ApplicationController
  def index
    @tutorials = WorkoutSet.order("created_at desc").includes(:type).where(type: Type.where(name:"Tutorial").take.id)
  end
end
