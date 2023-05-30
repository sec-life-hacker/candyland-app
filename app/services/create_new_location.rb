# frozen_string_literal: true

require 'http'

module Candyland
  # Create a new configuration file for a project
  class CreateNewLocation
    def initialize(config)
      @config = config
    end

    def api_url
      @config.API_URL
    end

    def call(current_account:, location_data:)
      config_url = "#{api_url}/locations"
      response = HTTP.auth("Bearer #{current_account.auth_token}")
                    .post(config_url, json: location_data)

      response.code == 201 ? JSON.parse(response.body.to_s) : raise
    end
  end
end
