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
            puts event.policies.to_json
            view :event, locals: {
              current_account: @current_account, event: event
            }
          rescue StandardError => e
            puts "#{e.inspect}\n#{e.backtrace}"
            flash[:error] = 'Event not found'
            routing.redirect @locations_route
          end

          routing.on 'participate' do
            routing.post do
              ParticipateEvent.new(App.config).call(@current_account, event_id)
              view :home

            rescue StandardError => e
              puts "#{e.inspect}\n#{e.backtrace}"
              flash[:error] = 'Event not found'
              routing.redirect @locations_route
            end
          end

          routing.on 'participants' do
            routing.post do
              ParticipateEvent.new(App.config).call(@current_account, event_id)

              routing.redirect @event_route
              flash[:notice] = 'Event Created'
            rescue StandardError => e
              puts "FAILURE adding participant: #{e.inspect}"
              flash[:error] = 'Could not add participant'
            ensure
              routing.redirect @events_route
            end
          end
        end


        # GET /events
        routing.get do
          events_list = GetAllEvents.new(App.config).call(@current_account)
          events = Events.new(events_list)
          locations_list = GetAllLocations.new(App.config).call(@current_account)
          locations = Locations.new(locations_list)
          view :events_all, locals: {
            current_account: @current_account,
            events: events,
            locations: locations,
          }
        end

        # POST /events
        routing.post do
          event_data = Form::NewEvent.new.call(routing.params)
          if event_data.failure?
            flash[:error] = Form.message_values(event_data)
            routing.halt
          end

          CreateNewEvent.new(App.config).call(
            current_account: @current_account,
            event_data: event_data.to_h
          )

          flash[:notice] = 'Event Created'
        rescue StandardError => e
          puts "FAILURE Creating Event: #{e.inspect}"
          flash[:error] = 'Could not create event'
        ensure
          routing.redirect @events_route
        end
      end
    end
  end
end
