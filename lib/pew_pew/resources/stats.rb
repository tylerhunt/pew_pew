module PewPew
  module Resources
    class Stats
      include Connection

      attr :domain

      def initialize(client, options={})
        @client = client
        @domain = options[:domain] || config.domain
      end

      def all
        get("#{domain}/stats")
      end

      def config
        @client.config
      end
      private :config
    end
  end
end
