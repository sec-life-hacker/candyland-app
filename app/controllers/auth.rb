# frozen_string_literal: true

require 'roda'
require_relative './app'

module Candyland
  # Web controller for Candyland API
  class App < Roda
    # rubocop:disable Metrics/BlockLength
    route('auth') do |routing|
      routing.is 'register' do
        # GET /auth/register
        routing.get do
          view :register
        end

        # POST /auth/register
        routing.post do
          account = RegisterAccount.new(App.config).call(
            username: routing.params['username'],
            email: routing.params['email'],
            password: routing.params['password']
          )

          session[:current_account] = account
          flash[:notice] = "Welcome! #{account['username']}!"
          routing.redirect '/'
        rescue StandardError
          flash.now[:error] = 'Account information invalid'
          response.status = 400
          view :register
        end
      end

      @login_route = '/auth/login'
      routing.is 'login' do
        # GET /auth/login
        routing.get do
          view :login
        end

        # POST /auth/login
        routing.post do
          account = AuthenticateAccount.new(App.config).call(
            username: routing.params['username'],
            password: routing.params['password']
          )

          session[:current_account] = account
          flash[:notice] = "Welcome back #{account['username']}!"
          routing.redirect '/'
        rescue StandardError
          flash.now[:error] = 'Username and password did not match our records'
          response.status = 400
          view :login
        end
      end

      routing.on 'logout' do
        routing.get do
          session[:current_account] = nil
          routing.redirect @login_route
        end
      end
    end
    # rubocop:enable Metrics/BlockLength
  end
end
