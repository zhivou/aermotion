class TransactionController < ApplicationController

  include PayPal::SDK::REST
  before_action :set_payment_info, only: [:details, :create_payment]

  def details
  end

  def create_payment
    workout = @workout_set
    @payment = PaypalPayment.setup(
        price: workout.price,
        item_name: workout.title,
        description: "Add description to WorkoutSets",
        return_url: "http://localhost:3000/payment_execute",
        cancel_url: workout_sets_path
    )
  end

  def payment_execute
    PaypalPayment.execute_payment(payment_params[:paymentId], payment_params[:PayerID])
    @payment_invoice = Payment.find(payment_params[:paymentId])
    p ''
  end

  private
  def set_payment_info
    @workout_set = WorkoutSet.find(params[:id])
  end

  def payment_params
    params.permit(:paymentId, :token, :PayerID, :id)
  end
end
