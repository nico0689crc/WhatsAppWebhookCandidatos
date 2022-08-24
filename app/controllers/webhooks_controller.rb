class WebhooksController < ApplicationController

  def index
    hub_verify_token_local = "landflewmeasure"
    hub_mode = params["hub.mode"] unless params["hub.mode"].nil?;
    hub_challenge = params["hub.challenge"] unless params["hub.challenge"].nil?;
    hub_verify_token = params["hub.verify_token"] unless params["hub.verify_token"].nil?;

    if hub_mode && hub_challenge && hub_verify_token && hub_verify_token == hub_verify_token_local
      render json: hub_challenge, status: :ok
    else
      render json: "Internal_server_error", status: :internal_server_error
    end
  end

  # POST /candidates
  def create
    phone_number_to = message = params[:webhook][:entry][0][:changes][0][:value][:messages][0][:from]
    message = params[:webhook][:entry][0][:changes][0][:value][:messages][0][:text][:body]
    
    if message  == "1"
      message_text = "Option 1"
    elsif message  == "2"
      message_text = "Option 2"
    elsif message  == "3"
      message_text = "Option 3"
    else
      message_text = "Option 4"
    end 

    body = { 
      "messaging_product" => "whatsapp",
      "to" => phone_number_to,
      "type" => "template",
      "template" => {
        "name" => "response_option",
        "language" => {
          "code" => "en"
        },
        "components": [
          {
            "type": "header",
            "parameters": [
              {
                "type": "text",
                "text": "Carlos Saul Menem"
              }
            ]
          },
          {
            "type": "body",
            "parameters": [
              {
                "type": "text",
                "text": message_text
              }
            ]
          }
        ]
      }
    }

    send_whatsapp_message(body)
  end

  def initial_message
    phone_number_to = params[:phone_number_to]
    full_name_to = params[:full_name_to]
    job_opening_name = params[:job_opening_name]
    recruiter_name = params[:recruiter_name]

    body = { 
      "messaging_product" => "whatsapp",
      "to" => phone_number_to,
      "type" => "template",
      "template" => {
        "name" => "initial_message",
        "language" => {
          "code" => "en"
        },
        "components": [
          {
            "type": "header",
            "parameters": [
              {
                "type": "text",
                "text": recruiter_name
              }
            ]
          },
          {
            "type": "body",
            "parameters": [
              {
                "type": "text",
                "text": full_name_to
              },
              {
                "type": "text",
                "text": job_opening_name
              }
            ]
          }
        ]
      }
    }

    send_whatsapp_message(body)
  end

  private
  
  def send_whatsapp_message(body)
    whatsapp_api = WhatsappApi.new
    whatsapp_api.send_message(body.to_json)
  end
end
