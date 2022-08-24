module Whatsapp
  class WhatsappApi
    include HTTParty

    def send_message(body)
      response = post(body, "messages")
      puts response.to_json
    end

    private

    def post(body, endpoint)
      HTTParty.post(
        "#{ENV["WHATSAPP_BASE_URL"]}/#{ENV["WHATSAPP_PHONE_NUMBER_ID"]}/#{endpoint}", 
        :body => body, 
        :headers => { 
          "Authorization" => "Bearer #{ENV["WHATSAPP_BARRER_TOKEN"]}",
          "Content-Type"  => "application/json" 
        }
      )
    end
  end
end

