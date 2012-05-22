module PewPew
  class Client
    include Connection

    def config
      @config ||= Config.new
    end

    def configure
      yield(config)
      config
    end

    def stats(domain=config.domain)
      (@stats ||= Resources::Stats.new(self)).for_domain(domain)
    end
  end
end
