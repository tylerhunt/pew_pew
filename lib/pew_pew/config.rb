module PewPew
  module Config
    BASE_URI = 'https://api.mailgun.net/v2'
    USER_AGENT = "PewPew Ruby Gem #{PewPew::VERSION}"

    # The Mailgun API key used to authenticate requests.
    # @return [String]
    attr :api_key, true

    # The default domain to use for resources that require a domain.
    # @return [String]
    attr :domain, true
  end
end
