# frozen_string_literal: true

require 'http'

module Candyland
  # Create a new event for a location
  class CreateNewEvent
    def initialize(config)
      @config = config
    end

    def api_url
      @config.API_URL
    end

    def call(current_account:, event_data:)
      config_url = "#{api_url}/events"
      response = HTTP.auth("Bearer #{current_account.auth_token}")
                    .post(config_url, json: event_data)

      response.code == 201 ? JSON.parse(response.body.to_s) : raise
    end
  end
end
