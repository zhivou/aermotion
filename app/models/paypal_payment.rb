require 'paypal-sdk-rest'

class PaypalPayment
  include PayPal::SDK::REST

  def initialize(price:,
                 item_name:,
                 description:,
                 return_url:,
                 cancel_url:)

    Payment.new({
      :intent =>  "sale",

      # Set payment type
      :payer =>  {
          :payment_method =>  "paypal"
      },

      # Set redirect URLs
      :redirect_urls => {
          :return_url => return_url,
          :cancel_url => cancel_url
      },

      # Set transaction object
      :transactions =>  [{

        # Items
        :item_list => {
            :items => [{
              :name => item_name,
              :sku => "item",
              :price => price,
              :currency => "USD",
              :quantity => 1
            }]
        },

        # Amount - must match item list breakdown price
        :amount =>  {
          :total =>  price,
          :currency =>  "USD"
        },
        :description =>  description
      }]
    })
  end

  def create(payment)
    # Create payment
    if payment.create
      # Capture redirect url
      payment.links.find{|v| v.rel == "approval_url" }.href
      # Redirect the customer to redirect_url
    else
      logger.error payment.error.inspect
    end
  end

  def execute_payment(id)
    payment = Payment.find(id)

    if payment.execute( :payer_id => "L8LM5D77TRWW4" )
      # Success Message
      # Note that you'll need to `Payment.find` the payment again to access user info like shipping address
    else
      payment.error # Error Hash
    end
  end
end