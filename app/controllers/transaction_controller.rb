class TransactionController < ApplicationController

  before_action :set_workout_set, only: [:create_payment]

  ##
  # Admin access only
  #
  def index
  end

  def create_payment
  end

  private
  def set_workout_set
    @workout_set = WorkoutSet.find(params[:id])
  end
end
