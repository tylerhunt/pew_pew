# frozen_string_literal: true

require 'dry/monads'
require 'dry/validation'
require 'uri'

Dry::Validation.load_extensions :monads

module PewPew
  class Contract < Dry::Validation::Contract
    register_macro :email_format do
      if value && !URI::MailTo::EMAIL_REGEXP.match?(value)
        key.failure 'has invalid format'
      end
    end
  end
end
