class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
  end

  def get_event
    data = JSON.parse(request.body.read)
  end
end
