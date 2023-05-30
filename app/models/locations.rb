# frozen_string_literal: true

require_relative 'location'

module Candyland
  # Behaviors of the currently logged in account
  class Locations
    attr_reader :all

    def initialize(locations_list)
      @all = locations_list.map do |location|
        Location.new(location['data'])
      end
    end
  end
end
