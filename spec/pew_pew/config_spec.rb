module PewPew
  RSpec.describe Config do
    {
      BASE_URI: 'https://api.mailgun.net/v2',
      USER_AGENT: "PewPew Ruby Gem #{VERSION}",
      USERNAME: 'api'
    }.each do |constant, value|
      context "::#{constant}" do
        subject { described_class.const_get(constant) }

        it { should == value }
      end
    end

    subject(:config) { Class.new { include Config }.new }

    context 'defaults' do
      its(:api_key) { should be_nil }
      its(:domain) { should be_nil }
    end

    context '#api_key=' do
      specify do
        expect { config.api_key = 'key-02n9f3ijl9sm9u97-8p7r-d7-15q-ui1' }
          .to change(config, :api_key)
          .to('key-02n9f3ijl9sm9u97-8p7r-d7-15q-ui1')
      end
    end

    context '#domain=' do
      specify do
        expect {
          config.domain = 'pewpew.mailgun.org'
        }.to change(config, :domain).to('pewpew.mailgun.org')
      end
    end
  end
end
