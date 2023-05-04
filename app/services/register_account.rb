# frozen_string_literal: true

require 'http'

module Candyland
  # Returns an authenticated user, or nil
  class RegisterAccount
    class BadRequestError < StandardError; end

    def initialize(config)
      @config = config
    end

    def call(username:, email:, password:)
      response = HTTP.post("#{@config.API_URL}/accounts",
                           json: { username:, email:, password: })

      raise(BadRequestError) unless response.code == 201

      response.parse['attributes']
    end
  end
end
