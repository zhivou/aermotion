class HomeController < ApplicationController
  def index
    @workout_sets = WorkoutSet.order("created_at desc").includes(:type).where(type: Type.where(name:"Set").take.id).limit(6) rescue nil
    @tutorials = WorkoutSet.order("created_at desc").includes(:type).where(type: Type.where(name:"Tutorial").take.id).limit(6) rescue nil
  end
end
