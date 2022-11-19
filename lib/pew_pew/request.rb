# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module PewPew
  # An abstract object used to define API requests.
  class Request
    def self.inherited(base)
      base.include Dry::Monads[:result]
      base.include Dry::Monads::Do.for(:call)
    end

    # @param api [API]
    # @param contract [Contract]
    def initialize(api:, contract:)
      self.api = api
      self.contract = contract
    end

  protected

    attr_accessor :api
    attr_accessor :contract

  private

    def validate(data)
      contract.call(data).to_monad.fmap { |values| values.to_h }
    end
  end
end
