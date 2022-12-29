# action frozen_string_literal: true

require_relative 'messages/send'
require_relative 'messages/send_mime'

module PewPew
  # Provide access to the mailing lists resource.
  #
  # See https://documentation.mailgun.com/en/latest/api-sending.html.
  class Messages
    def initialize(api:)
      self.api = api
    end

    # Creates and sends a new message.
    #
    # @example
    #   client.messages.send(
    #     domain: 'example.com',
    #     from: 'sender@example.com',
    #     to: 'recipient@example.com',
    #     subject: 'Welcome',
    #     text: 'Hello, world!',
    #   )
    #
    # @param domain [String] The account domain
    # @param from [String] Sender address
    # @param to [String] Recipient address
    # @param cc [String] CC address
    # @param bcc [String] BCC address
    # @param subject [String] Message subject
    # @param text [String] Text part of the message body
    # @param html [String] HTML part of the message body
    # @param attachment [String] File attachments
    # @param inline [String] Inline file attachments
    def send(**data)
      Send.new(api: api).call(**data)
    end

    # Creates and sends a new message in MIME format.
    #
    # @example
    #   client.messages.send(
    #     to: 'recipient@example.com',
    #     message: '<MIME content>',
    #     headers: {
    #       'X-Custom-Header' => 'value',
    #     }
    #   )
    #
    # @param domain [String] The account domain
    # @param to [String] Recipient address
    # @param message [String] MIME string of the message
    # @param headers [Hash] Extra header values
    def send_mime(**data)
      SendMIME.new(api: api).call(**data)
    end

  protected

    attr_accessor :api
  end
end
