# frozen_string_literal: true
module Candyland
  class Event
    attr_reader :id, :title, :description, :time, # basic info
                :location, :curator, :participants # detail

    def initialize(event_info)
      process_attributes(proj_info['attributes'])
      process_relationships(proj_info['relationships'])
      process_policies(proj_info['policies'])
    end

    def process_attributes(attributes)
      @id = attributes['id']
      @title = attributes['title']
      @description = attributes['description']
      @time = attributes['time']
    end

    def process_relationships(relationships)
      return unless relationships

      @curator = Account.new(['curator'])
      @location = Location.new(relationships['location'])
      @participants = process_participants(relationships['participants'])
    end

    def process_policies(policies)
      @policies = OpenStruct.new(policies)
    end

    def process_participants(participants)
      return nil unless participants

      participants.map { |account_info| Account.new(account_info) }
    end
  end
end
