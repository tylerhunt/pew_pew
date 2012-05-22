require 'faraday'
require 'faraday_middleware'

module PewPew
  module Connection
    class ResponseDecorator < Faraday::Response::Middleware
      def on_complete(env)
        env[:body].status = env[:status]
      end
    end

    def get(path, params={})
      connection.get(path, params).body
    end
    private :get

    def connection
      Faraday.new(
        url: config.endpoint,
        headers: { user_agent: config.user_agent }
      ) do |builder|
        builder.basic_auth(:api, config.api_key)
        builder.use(ResponseDecorator)
        builder.response(:mashify, mash_class: Response)
        builder.response(:json)
        builder.adapter(config.adapter)
      end
    end
    private :connection
  end
end
