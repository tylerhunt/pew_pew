# frozen_string_literal: true

require 'addressable/template'

require_relative '../contract'
require_relative '../request'

module PewPew
  class Lists
    class Remove < Request
      class Contract < PewPew::Contract
        params do
          required(:address).filled(:string)
        end

        rule(:address).validate(:email_format)
      end

      PATH = Addressable::Template.new('v3/lists/{address}')

      def initialize(contract: Contract.new, **options)
        super(contract: contract, **options)
      end

      def call(**data)
        values = yield validate(data)
        response = yield execute(**values)

        Success(response)
      end

    private

      def execute(address:)
        api.delete(PATH.expand(address: address))
      end
    end
  end
end
