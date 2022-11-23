# frozen_string_literal: true

require 'addressable/template'

require_relative '../contract'
require_relative '../request'

module PewPew
  class Messages
    class Send < Request
      class Contract < PewPew::Contract
        params do
          required(:domain).filled(:string)
          optional(:from).filled(:string)
          required(:to).filled(:string)
          optional(:cc).filled(:string)
          optional(:bcc).filled(:string)
          optional(:subject).filled(:string)
          optional(:html).filled(:string)
          optional(:text).filled(:string)
          optional(:attachment).filled(:string)
          optional(:inline).filled(:string)
        end

        rule :from do
          if value && !URI::MailTo::EMAIL_REGEXP.match?(value)
            key.failure 'has invalid format'
          end
        end

        rule :to do
          if value && !URI::MailTo::EMAIL_REGEXP.match?(value)
            key.failure 'has invalid format'
          end
        end

        rule :cc do
          if value && !URI::MailTo::EMAIL_REGEXP.match?(value)
            key.failure 'has invalid format'
          end
        end

        rule :bcc do
          if value && !URI::MailTo::EMAIL_REGEXP.match?(value)
            key.failure 'has invalid format'
          end
        end
      end

      PATH = Addressable::Template.new('v3/{domain}/messages')

      def initialize(contract: Contract.new, **options)
        super(contract: contract, **options)
      end

      def call(**data)
        values = yield validate(data)
        response = yield execute(**values)

        Success(response)
      end

    private

      def execute(domain:, **values)
        api.post(PATH.expand(domain: domain), values)
      end
    end
  end
end
