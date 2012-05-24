module PewPew
  module Config
    BASE_URI = 'https://api.mailgun.net/v2'
    USER_AGENT = "PewPew Ruby Gem #{PewPew::VERSION}"

    attr :api_key, true
    attr :domain, true
  end
end
