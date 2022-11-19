# frozen_string_literal: true

require_relative 'api'

require_relative 'lists'

module PewPew
  # The client object for accessing the Mailgun API.
  class Client
    # @example
    #   client = PewPew::Client.new(api_key: ENV.fetch('MAILGUN_API_KEY'))
    #
    # @param api_key [String] Mailgun API key
    def initialize(api_key:)
      self.api = API.new(api_key: api_key)
    end

    # Provides access to the mailing lists resource.
    #
    # @return [Lists] the lists resource
    def lists
      @lists ||= Lists.new(api: api)
    end

  protected

    attr_accessor :api
  end
end
