module PewPew
  class Client
    include Relax::Client

    # Returns a new client instance and configures its default values.
    def initialize
      config.base_uri = Config::BASE_URI
      config.user_agent = Config::USER_AGENT
      config.extend(Config)
    end

    # Builds a new instance of the logs resource for the given domain.
    #
    # @option options [String] :domain the domain name
    # @return <Resources::Logs> an instance of the logs resource
    def logs(options={})
      Resources::Logs.new(self, options)
    end

    # Builds a new instance of the messages resource for the given domain.
    #
    # @option options [String] :domain the domain name
    # @return <Resources::Messages> an instance of the messages resource
    def messages(options={})
      Resources::Messages.new(self, options)
    end

    # Builds a new instance of the routes resource for the given domain.
    #
    # @return <Resources::Logs> an instance of the routes resource
    def routes
      Resources::Routes.new(self)
    end

    # Builds a new instance of the stats resource for the given domain.
    #
    # @option options [String] :domain the domain name
    # @return <Resources::Stats> an instance of the stats resource
    def stats(options={})
      Resources::Stats.new(self, options)
    end
  end
end
