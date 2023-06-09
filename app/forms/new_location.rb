# frozen_string_literal: true

require_relative 'form_base'

module Candyland
  module Form
    class NewLocation < Dry::Validation::Contract
      config.messages.load_paths << File.join(__dir__, 'errors/new_location.yml')

      params do
        required(:name).filled
        required(:description).filled
        required(:coordinate).filled
      end
    end
  end
end
