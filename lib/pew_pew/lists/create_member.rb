# frozen_string_literal: true

require 'addressable/template'

require_relative '../contract'
require_relative '../request'

module PewPew
  class Lists
    class CreateMember < Request
      class Contract < PewPew::Contract
        SUSBSCRIBED_VALUES = %w[yes no].freeze
        UPSERT_VALUES = %w[yes no].freeze

        params do
          required(:list_address).filled(:string)
          required(:address).filled(:string)
          optional(:name).filled(:string)
          optional(:vars).filled(:string)
          optional(:subscribed).filled(included_in?: SUSBSCRIBED_VALUES)
          optional(:upsert).filled(included_in?: UPSERT_VALUES)
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

      PATH = Addressable::Template.new('v3/lists/{address}/members')

      def initialize(contract: Contract.new, **options)
        super(contract: contract, **options)
      end

      def call(**data)
        values = yield validate(data)
        response = yield execute(**values)

        Success(response)
      end

    private

      def execute(list_address:, **values)
        api.post(PATH.expand(address: list_address), values)
      end
    end
  end
end
