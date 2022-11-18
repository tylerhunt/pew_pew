module PewPew
  RSpec.describe Client do
    context '#config' do
      subject { described_class.new.config }

      its(:adapter) { should == Faraday.default_adapter }
      its(:base_uri) { should == Config::BASE_URI }
      its(:user_agent) { should == Config::USER_AGENT }

      its(:api_key) { should be_nil }
      its(:domain) { should be_nil }
    end

    context '#configure' do
      let(:client) { described_class.new }

      before do
        client.configure do |config|
          config.adapter = :typhoeus
          config.base_uri = 'https://api.mailgun.com/v2'
          config.user_agent = 'A PewPew Application'

          config.api_key = 'key-02n9f3ijl9sm9u97-8p7r-d7-15q-ui1'
          config.domain = 'pewpew.mailgun.org'
        end
      end

      subject { client.config }

      its(:adapter) { should == :typhoeus }
      its(:base_uri) { should == 'https://api.mailgun.com/v2' }
      its(:user_agent) { should == 'A PewPew Application' }

      its(:api_key) { should == 'key-02n9f3ijl9sm9u97-8p7r-d7-15q-ui1' }
      its(:domain) { should == 'pewpew.mailgun.org' }
    end

    {
      bounces: Resources::Bounces,
      campaigns: Resources::Campaigns,
      complaints: Resources::Complaints,
      lists: Resources::Lists,
      logs: Resources::Logs,
      mailboxes: Resources::Mailboxes,
      messages: Resources::Messages,
      routes: Resources::Routes,
      stats: Resources::Stats,
      unsubscribes: Resources::Unsubscribes,
    }.each do |method, resource_class|
      context "##{method}" do
        specify {
          resource = subject.send(method)

          expect(resource).to be_a resource_class
        }
      end
    end
  end
end
