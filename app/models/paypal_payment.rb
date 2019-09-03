require 'paypal-sdk-rest'

#
# sb-f9eex117376@personal.example.com
# gyN3z%R?
#

class PaypalPayment
  include PayPal::SDK::REST

  def self.setup(price:, item_name:, description:, return_url:, cancel_url:)

    payment = Payment.new({
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
              :quantity => 1,
              :category => "Digital"
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

    { redirect: create_p(payment), payment_info: payment }
  end

  def self.create_p(payment)
    # Create payment
    if payment.create
      # Capture redirect url
      payment.links.find{|v| v.rel == "approval_url" }.href
      #transaction.update_columns(payment_id: payment.id, approval_url: approval_url)

      # Redirect the customer to redirect_url
    else
      logger.error payment.error.inspect
    end
  end

  def self.execute_payment(id, payer)
    payment = Payment.find(id)

    if payment.execute( :payer_id => payer )
      # Success Message
      # Note that you'll need to `Payment.find` the payment again to access user info like shipping address
    else
      payment.error # Error Hash
    end
  end

end