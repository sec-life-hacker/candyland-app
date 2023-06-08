# frozen_string_literal: true

require 'http'

module Candyland
  # Returns all projects belonging to an account
  class GetEvent
    def initialize(config)
      @config = config
    end

    def call(current_account, event_id)
      response = HTTP.auth("Bearer #{current_account.auth_token}")
                    .get("#{@config.API_URL}/events/#{event_id}")

      response.code == 200 ? JSON.parse(response.to_s)['data'] : nil
    end
  end
end
