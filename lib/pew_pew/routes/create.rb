# frozen_string_literal: true

require_relative '../contract'
require_relative '../request'

module PewPew
  class Routes
    class Create < Request
      class Contract < PewPew::Contract
        params do
          required(:expression).filled(:string)
          optional(:action).filled(:string)
          optional(:description).filled(:string)
          optional(:priority).filled(:integer)
        end
      end

      PATH = 'v3/routes'

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
