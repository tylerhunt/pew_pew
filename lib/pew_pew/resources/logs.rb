module PewPew
  module Resources
    class Logs
      include Resource

      def all
        get("#{domain}/log")
      end

      def domain
        @domain ||= @options[:domain] || config.domain
      end
      private :domain
    end
  end
end
