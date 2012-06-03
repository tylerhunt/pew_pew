require 'faraday_middleware'

module PewPew
  module Resource
    include Relax::Resource

    class ResponseDecorator < Faraday::Response::Middleware
      def on_complete(env)
        if env[:body].is_a?(Array)
          items = env[:body]
          env[:body] = Response.new(items: items, total_count: items.length)
        end

        env[:body].status = env[:status]
      end
    end

    def get(*)
      super.body
    end
    private :get

    def post(*)
      super.body
    end
    private :post

    def put(*)
      super.body
    end
    private :put

    def delete(*)
      super.body
    end
    private :delete

    def connection
      super do |builder|
        builder.basic_auth(Config::USERNAME, config.api_key)

        builder.use(ResponseDecorator)
        builder.response(:mashify, mash_class: Response)
        builder.response(:json)

        builder.request(:multipart)
        builder.request(:url_encoded)
      end
    end
    private :connection
  end
end
