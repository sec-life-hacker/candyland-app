# frozen_string_literal: true

require_relative 'form_base'

module Candyland
  module Form
    class NewEvent < Dry::Validation::Contract
      config.messages.load_paths << File.join(__dir__, 'errors/new_event.yml')

      params do
        required(:title).filled
        required(:description).filled
        required(:time).filled
      end
    end
  end
end
