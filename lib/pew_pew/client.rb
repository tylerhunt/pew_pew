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
      get("#{domain}/stats")
    end
  end
end
