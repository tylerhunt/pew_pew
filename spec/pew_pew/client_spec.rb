require 'spec_helper'

describe PewPew::Client do
  context '#config' do
    subject { described_class.new.config }

    its(:adapter) { should == Faraday.default_adapter }
    its(:base_uri) { should == PewPew::Config::BASE_URI }
    its(:user_agent) { should == PewPew::Config::USER_AGENT }

    its(:api_key) { should be_nil }
    its(:domain) { should be_nil }
  end

  context '#configure' do
    subject do
      described_class.new.configure do |config|
        config.adapter = :typhoeus
        config.base_uri = 'https://api.mailgun.com/v2'
        config.user_agent = 'A PewPew Application'

        config.api_key = 'key-02n9f3ijl9sm9u97-8p7r-d7-15q-ui1'
        config.domain = 'pewpew.mailgun.org'
      end
    end

    its(:adapter) { should == :typhoeus }
    its(:base_uri) { should == 'https://api.mailgun.com/v2' }
    its(:user_agent) { should == 'A PewPew Application' }

    its(:api_key) { should == 'key-02n9f3ijl9sm9u97-8p7r-d7-15q-ui1' }
    its(:domain) { should == 'pewpew.mailgun.org' }
  end

  {
    logs: PewPew::Resources::Logs,
    mailboxes: PewPew::Resources::Mailboxes,
    messages: PewPew::Resources::Messages,
    routes: PewPew::Resources::Routes,
    stats: PewPew::Resources::Stats,
  }.each do |method, resource_class|
    context "##{method}" do
      specify { subject.send(method).should be_a(resource_class) }
    end
  end
end
