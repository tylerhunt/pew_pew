# frozen_string_literal: true

require 'addressable/template'

require_relative '../contract'
require_relative '../request'

module PewPew
  class Lists
    class RemoveMember < Request
      class Contract < PewPew::Contract
        params do
          required(:list_address).filled(:string)
          required(:address).filled(:string)
        end

        rule :list_address do
          unless URI::MailTo::EMAIL_REGEXP.match?(value)
            key.failure 'has invalid format'
          end
        end

        rule :address do
          unless URI::MailTo::EMAIL_REGEXP.match?(value)
            key.failure 'has invalid format'
          end
        end
      end

      PATH = Addressable::Template.new(
        'v3/lists/{list_address}/members/{address}',
      )

      def initialize(contract: Contract.new, **options)
        super(contract: contract, **options)
      end

      def call(**data)
        values = yield validate(data)
        response = yield execute(**values)

        Success(response)
      end

    private

      def execute(list_address:, address:)
        api.delete(PATH.expand(list_address: list_address, address: address))
      end
    end
  end
end
