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
    params = link_set_params
    param_container = OpenStruct.new(
        medium_id: params[:video_link],
        workout_id: params[:workout_link]
    )

    message = "Link was successfully created."
    message_out = false

    param_container.medium_id.each do |m|
      next if m == ""

      unless MediaWorkoutSet.where(medium_id: m, workout_set_id: param_container.workout_id) == []
        message += "\nExcept Video: '#{Medium.find(m).title}' and Workout Set: '#{WorkoutSet.find(param_container.workout_id).title}' already linked."
        next
      end

      link = MediaWorkoutSet.new(medium_id: m, workout_set_id: param_container.workout_id)
      if link.save
        message_out = true
        redirect_to admin_panel_path, notice: message
      else
        message_out = true
        flash[:notice] = "Not saved: #{link.errors}"
      end
    end
    redirect_to admin_panel_path, notice: message unless message_out
  end

  private
  def link_set_params
    params.require(:link_sets).permit(:workout_link, video_link: [])
  end
end
