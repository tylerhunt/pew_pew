shared_context 'API request', :resource do
  let(:client) { PewPew::Client.new }

  around do |example|
    client.configure do |config|
      config.api_key = ENV['MAILGUN_API_KEY']
      config.domain = ENV['MAILGUN_DOMAIN']
    end

    name = described_class.name.split(/::/).last.downcase

    vcr_options = {
      record: ENV['VCR_RECORD'] || :none,
      erb: { api_key: client.config.api_key, domain: client.config.domain }
    }

    VCR.use_cassette(name, vcr_options, &example)
  end
end
