class TransactionController < ApplicationController

  include PayPal::SDK::REST
  before_action :authenticate_user!
  before_action :set_payment_info, only: [:details, :create_payment]

  def details
  end

  def create_payment
    workout = @workout_set
    @payment = PaypalPayment.setup(
        price: workout.price,
        item_name: workout.id.to_s + " " + workout.title,
        description: workout.description,
        return_url: "https://aermotion.herokuapp.com/payment_execute",
        cancel_url: workout_sets_path
    )
    gon.payPall = @payment
  end

  def payment_execute
    PaypalPayment.execute_payment(payment_params[:paymentId], payment_params[:PayerID])
    @payment_invoice = Payment.find(payment_params[:paymentId])

    transaction = PayPalTransaction.new(
        transaction_id: payment_params[:paymentId],
        local_user_id: current_user.id.to_i,
        local_user_email: current_user.email,
        method: @payment_invoice.payer.payment_method,
        payer_id: payment_params[:PayerID],
        item: @payment_invoice.transactions[0].item_list.items[0].name,
        price: @payment_invoice.transactions[0].item_list.items[0].price.to_f,
        currency: @payment_invoice.transactions[0].item_list.items[0].currency,
        quantity: @payment_invoice.transactions[0].item_list.items[0].quantity,
        tax: @payment_invoice.transactions[0].item_list.items[0].tax.to_f,
        total: @payment_invoice.transactions[0].amount.total.to_f,
        paypal_created_time: @payment_invoice.create_time,
        status: @payment_invoice.transactions[0].related_resources[0].sale.state,
        error: @payment_invoice.error
    )

    unless PayPalTransaction.where(transaction_id: payment_params[:paymentId]).pluck("transaction_id").first == payment_params[:paymentId]
      transaction.save
    end

    if transaction[:status] == "completed"
      add_user_to_workouts(transaction[:item])
    end
  end

  private
  def set_payment_info
    @workout_set = WorkoutSet.find(params[:id])
  end

  def payment_params
    params.permit(:paymentId, :token, :PayerID, :id)
  end

  def add_user_to_workouts(item_name_with_id)
    workout_id = item_name_with_id.split[0]
    if current_user.workout_sets.where(id: workout_id).present?
      false
    else
      link = UsersWorkoutSet.new(user_id: current_user.id, workout_set_id: WorkoutSet.find(workout_id).id)
      if link.save
        flash[:notice] = "New Workout Set was successfuly added to My Videos"
      else
        flash[:notice] = "Not saved: #{link.errors}"
      end
      true
    end
  end
end
