# frozen_string_literal: true

require 'dry/monads'
require 'net/http'
require 'net/http/post/multipart'
require 'uri'

require_relative 'contract'

module PewPew
  class API
    include Dry::Monads[:result]

    ENDPOINT = 'https://api.mailgun.net/'

    # @param api_key [String] Mailgun API key
    # @param endpoint [String] Mailgun API endpoint
    def initialize(api_key:, endpoint: ENDPOINT)
      self.api_key = api_key
      self.uri = URI.parse(endpoint)
    end

    # Execute an HTTP `DELETE` request.
    #
    # @param path [String] request path relative to endpoint URI
    def delete(path)
      request = Net::HTTP::Delete.new(URI.join(uri, path))
      request.basic_auth USERNAME, api_key

      perform_request(request)
    end

    # Execute an HTTP `POST` request.
    #
    # @param path [String] request path relative to endpoint URI
    # @param data [Hash] request data (multipart/form-data)
    def post(path, data={}, multipart: false)
      request =
        unless multipart
          Net::HTTP::Post.new(URI.join(uri, path)).tap { |request|
            request.set_form_data data
          }
        else
          Net::HTTP::Post::Multipart.new(URI.join(uri, path), data)
        end

      request.basic_auth USERNAME, api_key

      perform_request(request)
    end

    # Execute an HTTP `PUT` request.
    #
    # @param path [String] request path relative to endpoint URI
    # @param data [Hash] request data (multipart/form-data)
    def put(path, data={})
      request = Net::HTTP::Put.new(URI.join(uri, path))
      request.basic_auth USERNAME, api_key
      request.set_form_data data

      perform_request(request)
    end

  protected

    attr_accessor :api_key
    attr_accessor :uri

  private

    OK = '200'

    CONTENT_TYPE = 'Content-Type'
    JSON = 'application/json'
    USERNAME = 'api'

    def http_client
      @http_client ||= Net::HTTP.new(uri.host, uri.port).tap { |http|
        http.use_ssl = URI::HTTPS === uri
      }
    end

    def perform_request(request)
      response = http_client.request(request)

      case response.code
      when OK
        Success(response)
      else
        Failure([:unexpected_response, response])
      end
    end
  end
end
