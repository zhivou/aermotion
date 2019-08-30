class TransactionController < ApplicationController

  before_action :set_payment_info, only: [:create_payment]

  ##
  # Admin access only
  #
  def index
  end

  def create_payment
    workout = @workout_set
    payment = PaypalPayment.setup(
        price: workout.price,
        item_name: workout.title,
        description: "Add description to WorkoutSets",
        return_url: "http://localhost:3000/payment_execute",
        cancel_url: workout_sets_path
    )
    redirect_to payment
  end

  def payment_execute
    PaypalPayment.execute_payment(payment_params[:paymentId], payment_params[:PayerID])
  end

  private
  def set_payment_info
    @workout_set = WorkoutSet.find(params[:id])
  end

  def payment_params
    params.permit(:paymentId, :token, :PayerID, :id)
  end
end
