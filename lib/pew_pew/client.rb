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

    def stats(options={})
      @stats ||= Resources::Stats.new(self, options)
    end
  end
end
