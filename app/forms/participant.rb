# frozen_string_literal: true

require_relative 'form_base'

module Candyland
  module Form
    class Participant < Dry::Validation::Contract
      config.messages.load_paths << File.join(__dir__, 'errors/participant.yml')

      params do
        required(:participant_email).filled
      end
    end
  end
end
