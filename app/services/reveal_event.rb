# frozen_string_literal: true

require 'http'

module Candyland
  # participant to event
  class RevealEvent
    def initialize(config)
      @config = config
    end

    def api_url
      @config.API_URL
    end

    def call(current_account, event_id)
      request_url = "#{api_url}/events/#{event_id}/reveal"
      response = HTTP.auth("Bearer #{current_account.auth_token}")
                    .patch(request_url)

      response.code == 200 ? JSON.parse(response.body.to_s)['data'] : raise
    end
  end
end
