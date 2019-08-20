class AdminPanelController < ApplicationController
  def index
    @users = User.all
    @workouts = WorkoutSet.all
    @videos = Medium.all
  end

  def new_video
    @workouts = WorkoutSet.all
  end

  def add_user
  end

  def destroy_video_connection
    @medium.destroy
    respond_to do |format|
      format.html { redirect_to media_url, notice: 'Video Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
