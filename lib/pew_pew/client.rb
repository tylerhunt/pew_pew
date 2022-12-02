# frozen_string_literal: true

require_relative 'api'

require_relative 'lists'
require_relative 'messages'
require_relative 'routes'

module PewPew
  # The client object for accessing the Mailgun API.
  class Client
    # @example
    #   # assuming ENV['MAILGUN_API_KEY'] is present:
    #   client = PewPew::Client.new
    #
    # @param api_key [String] Mailgun API key
    def initialize(api_key: ENV.fetch('MAILGUN_API_KEY'))
      self.api = API.new(api_key: api_key)
    end

    # Provides access to the mailing lists resource.
    #
    # @return [Lists] the lists resource
    def lists
      @lists ||= Lists.new(api: api)
    end

    # Provides access to the messages resource.
    #
    # @return [Messages] the messages resource
    def messages
      @messages ||= Messages.new(api: api)
    end

    # Provides access to the routes resource.
    #
    # @return [Routes] the routes resource
    def routes
      @routes ||= Routes.new(api: api)
    end

  protected

    attr_accessor :api
  end
end
