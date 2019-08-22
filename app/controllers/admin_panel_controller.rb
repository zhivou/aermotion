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

  def create_user
    param_container = format_params_user

    message = "Link was successfully created."
    param_container.workout_id.each do |w|
      next if w == ""
      unless UsersWorkoutSet.where(user_id: param_container.user_id, workout_set_id: w) == []
        message += "\nExcept User: '#{User.find(param_container.user_id).email}' and Workout Set: '#{WorkoutSet.find(w).title}' already linked."
        next
      end
      link = UsersWorkoutSet.new(user_id: param_container.user_id, workout_set_id: w)
      if link.save
      else
        flash[:notice] = "Not saved: #{link.errors}"
      end
    end
    redirect_to admin_panel_path, notice: message
  end

  def remove_user
    param_container = format_params_user

    message = "Link was successfully removed."
    param_container.workout_id.each do |w|
      next if w == ""
      if UsersWorkoutSet.where(user_id: param_container.user_id, workout_set_id: w) == []
        message += "\nExcept User: '#{User.find(param_container.user_id).email}' and Workout Set: '#{WorkoutSet.find(w).title}' already removed."
        next
      end
      link = UsersWorkoutSet.where(user_id: param_container.user_id, workout_set_id: w)
      link.delete_all
    end
    redirect_to admin_panel_path, notice: message
  end

  private
  def link_set_params
    params.require(:link_sets).permit(:workout_link, :user_link, workout_link_list:[], video_link: [])
  end

  def format_params
    OpenStruct.new(
        medium_id: link_set_params[:video_link],
        workout_id: link_set_params[:workout_link]
    )
  end

  def format_params_user
    OpenStruct.new(
        user_id: link_set_params[:user_link],
        workout_id: link_set_params[:workout_link_list]
    )
  end
end
