module PewPew
  class Client
    include Relax::Client

    def initialize
      config.base_uri = Config::BASE_URI
      config.user_agent = Config::USER_AGENT
      config.extend(Config)
    end

    def logs(options={})
      Resources::Logs.new(self, options)
    end

    def stats(options={})
      Resources::Stats.new(self, options)
    end
  end
end
