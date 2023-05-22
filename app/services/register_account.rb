# frozen_string_literal: true

require 'http'

module Candyland
  # Returns an authenticated user, or nil
  class RegisterAccount
    class InvalideAccount < StandardError;
      def message = 'This account can no longer be created: please start again'
    end

    def initialize(config)
      @config = config
    end

    def call(username:, email:, password:)
      response = HTTP.post("#{@config.API_URL}/accounts",
                           json: { username:, email:, password: })

      raise(BadRequestError) unless response.code == 201

      response.parse['data']['attributes']
    end
  end
end
