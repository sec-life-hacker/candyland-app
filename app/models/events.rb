# frozen_string_literal: true

require_relative 'location'

module Candyland
  # Behaviors of the currently logged in account
  class Events
    attr_reader :all

    def initialize(events_list)
      @all = events_list.map do |event|
        Event.new(event)
      end
    end
  end
end
