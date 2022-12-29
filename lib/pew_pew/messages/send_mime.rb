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

        rule(:to).validate(:email_format)
      end

      MIME_TYPE = 'application/octet-stream'
      PATH = Addressable::Template.new('v3/{domain}/messages.mime')

      def initialize(contract: Contract.new, **options)
        super(contract: contract, **options)
      end

      def call(**data)
        headers = data.delete(:headers) || {}

        values = yield validate(data)
        response = yield execute(**values.merge(headers: headers))

        Success(response)
      end

    private

      def execute(domain:, message:, headers:, **values)
        message = Multipart::Post::UploadIO.new(
          StringIO.new(message),
          MIME_TYPE,
        )

        api.post(
          PATH.expand(domain: domain),
          values.merge(headers).merge(message: message),
          multipart: true,
        )
      end
    end
  end
end
