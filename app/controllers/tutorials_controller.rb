class TutorialsController < ApplicationController
  def index
    if user_signed_in?
      @tutorials = WorkoutSet.includes(:type).where(type: Type.where(name:"Tutorial").take.id).where.not(id: current_user.workout_sets.includes(:type).each {|i| i}) rescue nil
    else
      @tutorials = WorkoutSet.order("created_at desc").includes(:type).where(type: Type.where(name:"Tutorial").take.id) rescue nil
    end
  end
end
