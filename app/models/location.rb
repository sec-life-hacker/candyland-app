# frozen_string_literal: true
module Candyland
  # Models a Location
  class Location
    attr_reader :id, :name, :description, :coordinate # basic info

    def initialize(info)
      process_attributes(info['attributes'])
    end

    private

    def process_attributes(attributes)
      @id             = attributes['id']
      @name           = attributes['name']
      @description    = attributes['description']
      @coordinate     = attributes['coordinate']
    end
  end
end
