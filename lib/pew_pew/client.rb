module PewPew
  class Client
    include Relax::Client

    # Returns a new client instance and configures its default values.
    def initialize
      config.base_uri = Config::BASE_URI
      config.user_agent = Config::USER_AGENT
      config.extend(Config)
    end

    # Builds a new instance of the bounces resource for the given domain.
    #
    # @option options [String] :domain the domain name
    # @return <Resources::Bounces> an instance of the bounces resource
    def bounces(options={})
      Resources::Bounces.new(self, options)
    end

    # Builds a new instance of the campaigns resource for the given domain.
    #
    # @option options [String] :domain the domain name
    # @return <Resources::Campaigns> an instance of the complaints resource
    def campaigns(options={})
      Resources::Campaigns.new(self, options)
    end

    # Builds a new instance of the complaints resource for the given domain.
    #
    # @option options [String] :domain the domain name
    # @return <Resources::Complaints> an instance of the complaints resource
    def complaints(options={})
      Resources::Complaints.new(self, options)
    end

    # Builds a new instance of the lists resource.
    #
    # @return <Resources::Lists> an instance of the lists resource
    def lists
      Resources::Lists.new(self)
    end

    # Builds a new instance of the logs resource for the given domain.
    #
    # @option options [String] :domain the domain name
    # @return <Resources::Logs> an instance of the logs resource
    def logs(options={})
      Resources::Logs.new(self, options)
    end

    # Builds a new instance of the mailboxes resource for the given domain.
    #
    # @option options [String] :domain the domain name
    # @return <Resources::Mailboxes> an instance of the mailboxes resource
    def mailboxes(options={})
      Resources::Mailboxes.new(self, options)
    end

    # Builds a new instance of the messages resource for the given domain.
    #
    # @option options [String] :domain the domain name
    # @return <Resources::Messages> an instance of the messages resource
    def messages(options={})
      Resources::Messages.new(self, options)
    end

    # Builds a new instance of the routes resource.
    #
    # @return <Resources::Routes> an instance of the routes resource
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

    # Builds a new instance of the unsubscribes resource for the given domain.
    #
    # @option options [String] :domain the domain name
    # @return <Resources::Unsubscribes> an instance of the unsubscribes resource
    def unsubscribes(options={})
      Resources::Unsubscribes.new(self, options)
    end
  end
end
