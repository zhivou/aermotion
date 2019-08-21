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
    @link = MediaWorkoutSet.new(medium_params)

    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: 'Medium was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def medium_params
    params.permit(:title, :video)
  end
end
