# frozen_string_literal: true

require_relative '../contract'
require_relative '../request'

module PewPew
  class Lists
    class Create < Request
      # @param address [String] The search string
      # @param name [String] The search string
      # @param description [String] whether to do an exact match
      # @param access_level [String] number of results
      # @param reply_preference [String] number of results
      class Contract < PewPew::Contract
        ACCESS_LEVELS = %w[readonly members everyone].freeze
        REPLY_PREFERENCES = %w[list sender].freeze

        params do
          required(:address).filled(:string)
          optional(:name).filled(:string)
          optional(:description).filled(:string)
          optional(:access_level).filled(included_in?: ACCESS_LEVELS)
          optional(:reply_preference).filled(included_in?: REPLY_PREFERENCES)
        end

        rule :address do
          unless URI::MailTo::EMAIL_REGEXP.match?(value)
            key.failure 'has invalid format'
          end
        end
      end

      PATH = 'v3/lists'

      def initialize(contract: Contract.new, **options)
        super(contract: contract, **options)
      end

      def call(**data)
        values = yield validate(data)
        response = yield execute(values)

        Success(response)
      end

    private

      def execute(values)
        api.post(PATH, values)
      end
    end
  end
end