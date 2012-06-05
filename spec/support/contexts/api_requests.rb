shared_context 'API request', :resource do
  let(:cassette_name) { described_class.name.split(/::/).last.downcase }
  let(:client) { PewPew::Client.new }

  around do |example|
    client.configure do |config|
      config.api_key = ENV['MAILGUN_API_KEY']
      config.domain = ENV['MAILGUN_DOMAIN']
    end

    basic_auth = Base64.encode64(
      "#{PewPew::Config::USERNAME}:#{client.config.api_key}"
    ).strip

    vcr_options = {
      record: (ENV['VCR_RECORD'] || :none).to_sym,
      match_requests_on: [:method, :uri, :headers, :body],
      erb: {
        basic_auth: basic_auth,
        domain: client.config.domain,
        user_agent: client.config.user_agent
      }
    }

    VCR.use_cassette(cassette_name, vcr_options, &example)
  end
end
