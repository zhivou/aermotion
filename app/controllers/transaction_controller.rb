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
        status: @payment_invoice.state,
        error: @payment_invoice.error
    )

    transaction.save
  end

  private
  def set_payment_info
    @workout_set = WorkoutSet.find(params[:id])
  end

  def payment_params
    params.permit(:paymentId, :token, :PayerID, :id)
  end
end
