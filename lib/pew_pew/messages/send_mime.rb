# frozen_string_literal: true

require 'addressable/template'
require 'multipart/post/upload_io'

require_relative '../contract'
require_relative '../request'

module PewPew
  class Messages
    class SendMIME < Request
      class Contract < PewPew::Contract
        params do
          required(:domain).filled(:string)
          required(:to).filled(:string)
          optional(:message).filled(:string)
        end

        rule :to do
          if value && !URI::MailTo::EMAIL_REGEXP.match?(value)
            key.failure 'has invalid format'
          end
        end
      end

      MIME_TYPE = 'application/octet-stream'
      PATH = Addressable::Template.new('v3/{domain}/messages.mime')

      def initialize(contract: Contract.new, **options)
        super(contract: contract, **options)
      end

      def call(**data)
        values = yield validate(data)
        response = yield execute(**values)

        Success(response)
      end

    private

      def execute(domain:, message:, **values)
        message = Multipart::Post::UploadIO.new(
          StringIO.new(message),
          MIME_TYPE,
        )

        api.post(
          PATH.expand(domain: domain),
          values.merge(message: message),
          multipart: true,
        )
      end
    end
  end
end
