require 'faraday'
require 'faraday/mashify'
require 'faraday/multipart'

module PewPew
  module Resource
    include Relax::Resource

    class ResponseDecorator < Faraday::Middleware
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
      super { |builder|
        builder.set_basic_auth Config::USERNAME, config.api_key

        builder.use ResponseDecorator
        builder.response :mashify, mash_class: Response
        builder.response :json, content_type: //

        builder.request :multipart
        builder.request :url_encoded
      }
    end
    private :connection
  end
end
