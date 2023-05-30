# frozen_string_literal: true

require 'roda'
require_relative './app'

module Candyland
  # Web controller for Candyland API
  class App < Roda
    route('locations') do |routing|
      routing.on do
        routing.redirect '/auth/login' unless @current_account.logged_in?
        @locations_route = '/locations'

        routing.get do
          locations_list = GetAllLocations.new(App.config).call(@current_account)
          locations = Locations.new(locations_list)
          view :locations_all, locals: {
            current_account: @current_account, locations: locations
          }
        end

        routing.post do
          location_data = Form::NewLocation.new.call(routing.params)

          if location_data.failure?
            flash[:error] = Form.message_values(location_data)
            routing.halt
          end

          CreateNewLocation.new(App.config).call(
            current_account: @current_account,
            location_data: location_data.to_h
          )

          flash[:notice] = 'Add events to this new location'
        rescue StandardError => e
          puts "FAILURE Creating Location: #{e.inspect}"
          flash[:error] = 'Could not create location'
        ensure
          routing.redirect @locations_route
        end
      end
    end
  end
end
