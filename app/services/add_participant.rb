# frozen_string_literal: true

require 'http'

module Candyland
  # add participant to an event
  class AddParticipant
    def initialize(config)
      @config = config
    end

    def api_url
      @config.API_URL
    end

    def call(current_account, event_id, participant_data)
      request_url = "#{api_url}/events/#{event_id}/participants"
      response = HTTP.auth("Bearer #{current_account.auth_token}")
                    .put(request_url, json: participant_data)

      response.code == 200 ? JSON.parse(response.body.to_s) : raise
    end
  end
end
