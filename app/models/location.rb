# frozen_string_literal: true
module Candyland
  # Models a Location
  class Location
    attr_reader :id, :name, :description, :coordinate, # basic info
                :finder, :events, :policies # full details

    def initialize(info)
      process_attributes(info['attributes'])
      process_relationships(info['relationships'])
      process_policies(info['policies'])
    end

    private

    def process_attributes(attributes)
      @id             = attributes['id']
      @name           = attributes['name']
      @description    = attributes['description']
      @coordinate     = attributes['coordinate']
    end

    def process_relationships(relationships)
      return unless relationships

      @finder = Account.new(relationships['finder'])
      @events = process_events(relationships['events'])
    end

    def process_policies(policies)
      @policies = OpenStruct.new(policies)
    end

    def process_events(events_info)
      return nil unless events_info

      events_info.map { |event_info| Event.new(event_info) }
    end
  end
end
