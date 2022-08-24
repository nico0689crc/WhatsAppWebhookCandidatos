class WebhooksController < ApplicationController
  def index
    hub_verify_token_local = "landflewmeasure"
    hub_mode = params["hub.mode"] unless params["hub.mode"].nil?;
    hub_challenge = params["hub.challenge"] unless params["hub.challenge"].nil?;
    hub_verify_token = params["hub.verify_token"] unless params["hub.verify_token"].nil?;

    if hub_mode && hub_challenge && hub_verify_token && hub_verify_token == hub_verify_token_local
      render json: hub_challenge, status: :ok
    else
      render status: :internal_server_error
    end
  end
end
