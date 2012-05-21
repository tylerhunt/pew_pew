module PewPew
  class Config
    ENDPOINT = 'https://api.mailgun.net/v2'
    USER_AGENT = "PewPew Ruby Gem #{PewPew::VERSION}"

    attr :api_key, true
    attr :domain, true
    attr :endpoint, true
    attr :user_agent, true

    def initialize
      self.endpoint = ENDPOINT
      self.user_agent = USER_AGENT
    end
  end
end
