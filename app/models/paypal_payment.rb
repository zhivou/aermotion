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
      :experience_profile_id => fetch_paypal_web_experience_profile.id,

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
    if payment.create
      payment.links.find{|v| v.rel == "approval_url" }.href
    else
      logger.error payment.error.inspect
    end
  end

  def self.execute_payment(id, payer)
    payment = Payment.find(id)

    if payment.execute( :payer_id => payer )
      # TODO: Add new table Transactions here and create a new record. Use Payment.find to get all
      # TODO: data, Execute User -> WorkoutSets adding
    else
      payment.error # Error Hash
    end
  end

  def self.fetch_paypal_web_experience_profile(profile_name: 'media_payment')
    experience_profiles = PayPal::SDK::REST::WebProfile.get_list
    experience_profile = experience_profiles.find { |profile| profile.name == profile_name }
    if experience_profile.nil?
      experience_profile = PayPal::SDK::REST::WebProfile.new(
          name: profile_name,
          temporary: false,
          input_fields: {
              no_shipping: 1,
              address_override: 1
          }
      )
      experience_profile.create
    end
    experience_profile
  end
end