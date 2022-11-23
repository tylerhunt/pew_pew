# frozen_string_literal: true

require 'addressable/template'

require_relative '../contract'
require_relative '../request'

module PewPew
  class Lists
    class UpdateMember < Request
      class Contract < PewPew::Contract
        SUSBSCRIBED_VALUES = %w[yes no].freeze
        UPSERT_VALUES = %w[yes no].freeze

        params do
          required(:list_address).filled(:string)
          required(:address).filled(:string)
          optional(:name).filled(:string)
          optional(:vars).filled(:string)
          optional(:subscribed).filled(included_in?: SUSBSCRIBED_VALUES)
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

      def execute(list_address:, address:, **values)
        path = PATH.expand(list_address: list_address, address: address)

        api.put(path, values)
      end
    end
  end
end
