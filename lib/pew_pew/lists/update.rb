# frozen_string_literal: true

require_relative '../contract'
require_relative '../request'

module PewPew
  class Lists
    class Update < Request
      class Contract < PewPew::Contract
        ACCESS_LEVELS = %w[readonly members everyone].freeze
        REPLY_PREFERENCES = %w[list sender].freeze

        params do
          required(:list_address).filled(:string)
          optional(:address).filled(:string)
          optional(:name).filled(:string)
          optional(:description).filled(:string)
          optional(:access_level).filled(included_in?: ACCESS_LEVELS)
          optional(:reply_preference).filled(included_in?: REPLY_PREFERENCES)
        end

        rule :list_address do
          unless URI::MailTo::EMAIL_REGEXP.match?(value)
            key.failure 'has invalid format'
          end
        end

        rule :address do
          if value && !URI::MailTo::EMAIL_REGEXP.match?(value)
            key.failure 'has invalid format'
          end
        end
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

      def execute(list_address:, **values)
        api.put(PATH.expand(address: list_address), values)
      end
    end
  end
end
