require 'faraday'

module PewPew
  module Connection
    def get(path, params={})
      connection.get(path, params)
    end
    private :get

    def connection
      Faraday.new(
        url: config.endpoint,
        headers: { user_agent: config.user_agent }
      ) do |builder|
        builder.basic_auth(:api, config.api_key)
        builder.adapter(config.adapter)
      end
    end
    private :connection
  end
end
