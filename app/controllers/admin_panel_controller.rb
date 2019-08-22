class AdminPanelController < ApplicationController
  def index
    @users = User.all
    @workouts = WorkoutSet.all
    @videos = Medium.all
  end

  def new_video
    @workouts = WorkoutSet.all
  end

  def create_video
    param_container = format_params
    message = "Link was successfully created."
    param_container.medium_id.each do |m|
      next if m == ""
      unless MediaWorkoutSet.where(medium_id: m, workout_set_id: param_container.workout_id) == []
        message += "\nExcept Video: '#{Medium.find(m).title}' and Workout Set: '#{WorkoutSet.find(param_container.workout_id).title}' already linked."
        next
      end
      link = MediaWorkoutSet.new(medium_id: m, workout_set_id: param_container.workout_id)
      if link.save
      else
        flash[:notice] = "Not saved: #{link.errors}"
      end
    end
    redirect_to admin_panel_path, notice: message
  end

  def remove_video
    param_container = format_params
    message = "Link was successfully removed."
    param_container.medium_id.each do |m|
      next if m == ""
      if MediaWorkoutSet.where(medium_id: m, workout_set_id: param_container.workout_id) == []
        message += "\nExcept Video: '#{Medium.find(m).title}' and Workout Set: '#{WorkoutSet.find(param_container.workout_id).title}' already removed."
        next
      end
      link = MediaWorkoutSet.where(medium_id: m, workout_set_id: param_container.workout_id)
      link.delete_all
    end
    redirect_to admin_panel_path, notice: message
  end

  private
  def link_set_params
    params.require(:link_sets).permit(:workout_link, video_link: [])
  end

  def format_params
    params = link_set_params
    OpenStruct.new(
        medium_id: params[:video_link],
        workout_id: params[:workout_link]
    )
  end
end
