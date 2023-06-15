# frozen_string_literal: true
module Candyland
  class Event
    attr_reader :id, :title, :description, :time, # basic info
                :location, :curator, :participants, :policies # detail

    def initialize(event_info)
      process_attributes(event_info['attributes'])
      process_hidden_infos(event_info['hidden_infos'])
      process_relationships(event_info['relationships'])
      process_policies(event_info['policies'])
    end

    def process_attributes(attributes)
      @id = attributes['id']
      @title = attributes['title']
      @description = attributes['description']
      @time = attributes['time']
    end

    def process_hidden_infos(hidden_infos)
      return unless hidden_infos

      @time = hidden_infos['time']
      @location = Location.new(hidden_infos['location'])
    end

    def process_relationships(relationships)
      return unless relationships

      @curator = Account.new(['curator'])
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
