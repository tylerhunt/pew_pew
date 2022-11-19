# frozen_string_literal: true

require 'dry/monads'
require 'dry/validation'

Dry::Validation.load_extensions :monads

module PewPew
  class Contract < Dry::Validation::Contract
  end
end
