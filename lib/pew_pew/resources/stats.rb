module PewPew
  module Resources
    class Stats
      include Resource

      attr :domain

      def all
        get("#{domain}/stats")
      end

      def domain
        @domain ||= @options[:domain] || config.domain
      end
      private :domain
    end
  end
end
