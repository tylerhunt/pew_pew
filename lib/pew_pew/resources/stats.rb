module PewPew
  module Resources
    class Stats
      include Connection

      def initialize(client)
        @client = client
      end

      def for_domain(domain)
        get("#{domain}/stats")
      end

      def config
        @client.config
      end
      private :config
    end
  end
end
