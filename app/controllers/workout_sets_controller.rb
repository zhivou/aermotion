class WorkoutSetsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :is_admin?, only: [:new, :edit, :update, :create, :destroy]
  before_action :set_workout_set, only: [:show, :edit, :update, :destroy]
  before_action :get_set, only: [:index]

  # GET /workout_sets
  # GET /workout_sets.json
  def index
    if user_signed_in?
      @workout_sets = WorkoutSet.includes(:type).page(params[:page]).per(12).where(type: Type.where(name:"Set").take.id).where.not(id: current_user.workout_sets.order(id: :desc).includes(:type).each {|i| i}) rescue nil
    else
      @workout_sets = WorkoutSet.includes(:type).where(type: Type.where(name:"Set").take.id).order(id: :desc).page(params[:page]).per(12) rescue nil
    end
  end

  # GET /workout_sets/1
  # GET /workout_sets/1.json
  def show
  end

  # GET /workout_sets/new
  def new
    @workout_set = WorkoutSet.new
  end

  # GET /workout_sets/1/edit
  def edit
  end

  # POST /workout_sets
  # POST /workout_sets.json
  def create
    @workout_set = WorkoutSet.new(workout_set_params)

    respond_to do |format|
      if @workout_set.save
        format.html { redirect_to @workout_set, notice: 'Workout set was successfully created.' }
        format.json { render :show, status: :created, location: @workout_set }
      else
        format.html { render :new }
        format.json { render json: @workout_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workout_sets/1
  # PATCH/PUT /workout_sets/1.json
  def update
    respond_to do |format|
      if @workout_set.update(workout_set_params)
        format.html { redirect_to @workout_set, notice: 'Workout set was successfully updated.' }
        format.json { render :show, status: :ok, location: @workout_set }
      else
        format.html { render :edit }
        format.json { render json: @workout_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workout_sets/1
  # DELETE /workout_sets/1.json
  def destroy
    @workout_set.destroy
    respond_to do |format|
      format.html { redirect_to workout_sets_url, notice: 'Workout set was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_workout_set
    @workout_set = WorkoutSet.find(params[:id])
  end

  def get_set
    @type = Type.where(name:"Set").take.id rescue nil
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def workout_set_params
    params.require(:workout_set).permit(
        :title,
        :price,
        :type_id,
        :description,
        :main_image,
        types_attributes: [:id, :name, :_destroy]
    )
  end
end
