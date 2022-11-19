# frozen_string_literal: true

require_relative 'lists/create'
require_relative 'lists/remove'

module PewPew
  # Provide access to the mailing lists resource.
  #
  # See https://documentation.mailgun.com/en/latest/api-mailinglists.html.
  class Lists
    def initialize(api:)
      self.api = api
    end

    # Creates a new mailing list.
    #
    # @example
    #   client.lists.create(address: 'list@example.com')
    #
    # @param address [String]
    # @param name [String] Mailing list name
    # @param description [String] Mailing list description
    # @param access_level [String] `list` (default) or `sender`
    # @param reply_preference [String]
    def create(**data)
      Create.new(api: api).call(**data)
    end

    # Removes a mailing list.
    #
    # @example
    #   client.lists.remove(address: 'list@example.com')
    #
    # @param address [String]
    def remove(address:)
      Remove.new(api: api).call(address: address)
    end

  protected

    attr_accessor :api
  end
end
