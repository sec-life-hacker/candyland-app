# frozen_string_literal: true

require 'roda'
require_relative './app'

module Candyland
  # Web controller for Candyland API
  class App < Roda
    route('account') do |routing|
      routing.on do
        # GET /account/:username
        routing.get String do |username|
          if @current_account && @current_account['username'] == username
            view :account, locals: { current_account: @current_account }
          else
            routing.redirect '/auth/login'
          end
        end
      end
    end
  end
end
