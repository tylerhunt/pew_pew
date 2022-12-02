# frozen_string_literal: true

require 'addressable/template'

require_relative '../contract'
require_relative '../request'

module PewPew
  class Routes
    class Remove < Request
      class Contract < PewPew::Contract
        params do
          required(:id).filled(:string)
        end
      end

      PATH = Addressable::Template.new('v3/routes/{id}')

      def initialize(contract: Contract.new, **options)
        super(contract: contract, **options)
      end

      def call(**data)
        values = yield validate(data)
        response = yield execute(**values)

        Success(response)
      end

    private

      def execute(id:)
        api.delete(PATH.expand(id: id))
      end
    end
  end
end
