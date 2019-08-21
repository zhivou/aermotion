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

    param_container.medium_id.each do |m|
      next if m == ""
      next unless MediaWorkoutSet.where(medium_id: m, workout_set_id: param_container.workout_id) == []

      link = MediaWorkoutSet.new(medium_id: m, workout_set_id: param_container.workout_id)
      unless link.save
        format.html { render root_path }
        format.json { render json: link.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def link_set_params
    params.require(:link_sets).permit(:workout_link, video_link: [])
  end
end
