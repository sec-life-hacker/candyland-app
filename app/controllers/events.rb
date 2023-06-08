# frozen_string_literal: true

require 'roda'
require_relative './app'

module Candyland
  # Web controller for Candyland API
  class App < Roda
    route('events') do |routing|
      routing.on do
        routing.redirect '/auth/login' unless @current_account.logged_in?
        @events_route = '/events'

        routing.on String do |event_id|
          @event_route = "#{@events_route}/#{event_id}"

          # GET /events/[event_id]
          routing.get do
            event_info = GetEvent.new(App.config).call(@current_account, event_id)
            event = Event.new(event_info)
            view :event, locals: {
              current_account: @current_account, event: event
            }
          rescue StandardError => e
            puts "#{e.inspect}\n#{e.backtrace}"
            flash[:error] = 'Event not found'
            routing.redirect @locations_route
          end
        end
      end
    end
  end
end
