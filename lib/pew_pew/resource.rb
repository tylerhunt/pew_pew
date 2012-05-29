require 'faraday_middleware'

module PewPew
  module Resource
    include Relax::Resource

    class ResponseDecorator < Faraday::Response::Middleware
      def on_complete(env)
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
