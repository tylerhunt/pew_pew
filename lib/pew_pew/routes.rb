# action frozen_string_literal: true

require_relative 'routes/create'
require_relative 'routes/remove'

module PewPew
  # Provide access to the routes resource.
  #
  # See https://documentation.mailgun.com/en/latest/api-routes.html
  class Routes
    def initialize(api:)
      self.api = api
    end

    # Creates a new route.
    #
    # @example
    #   client.routes.create(expression: "match_recipient('test@example.com')")
    #
    # @param expression [String] Filter expression
    # @param action [String] Action to execute
    # @param description [String] Route description
    # @param priority [Integer] Route priority (default: 0)
    def create(**data)
      Create.new(api: api).call(**data)
    end

    # Removes a route.
    #
    # @example
    #   client.routes.remove(id: '37c4b621acab5be520a43766')
    #
    # @param id [String] Route ID
    def remove(**data)
      Remove.new(api: api).call(**data)
    end

  protected

    attr_accessor :api
  end
end
