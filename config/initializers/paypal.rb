# include PayPal::SDK::REST
# include PayPal::SDK::Core::Logging
#
# require 'paypal-sdk-rest'
# require "securerandom"
#
# PayPal::SDK.load("config/paypal.yml", Rails.env)
# PayPal::SDK.logger = Rails.logger
#
# @webhook = Webhook.new({
#     :url => "https://24.11.94.203/webhooks",
#     :event_types => [
#         {
#             :name => "PAYMENT.AUTHORIZATION.CREATED"
#         },
#         {
#             :name => "PAYMENT.AUTHORIZATION.VOIDED"
#         }
#     ]
# })
#
# begin
#   @webhook = @webhook.create
#   logger.info "Webhook[#{@webhook.id}] created successfully"
# rescue ResourceNotFound => err
#   logger.error @webhook.error.inspect
# end