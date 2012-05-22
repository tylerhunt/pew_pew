require 'spec_helper'

describe PewPew::Client do
  context '#config' do
    subject { described_class.new.config }

    it { should be_a(PewPew::Config) }

    its(:adapter) { should == Faraday.default_adapter }
    its(:api_key) { should be_nil }
    its(:domain) { should be_nil }
    its(:endpoint) { should == PewPew::Config::ENDPOINT }
    its(:user_agent) { should == PewPew::Config::USER_AGENT }
  end

  context '#configure' do
    subject do
      described_class.new.configure do |config|
        config.adapter = :typhoeus
        config.api_key = 'key-02n9f3ijl9sm9u97-8p7r-d7-15q-ui1'
        config.domain = 'pewpew.mailgun.org'
        config.endpoint = 'https://api.mailgun.com/v2'
        config.user_agent = 'A PewPew Application'
      end
    end

    its(:adapter) { should == :typhoeus }
    its(:api_key) { should == 'key-02n9f3ijl9sm9u97-8p7r-d7-15q-ui1' }
    its(:domain) { should == 'pewpew.mailgun.org' }
    its(:endpoint) { should == 'https://api.mailgun.com/v2' }
    its(:user_agent) { should == 'A PewPew Application' }
  end

  context '#stats' do
    let!(:endpoint) { PewPew::Resources::Stats.new(subject) }

    before(:each) { PewPew::Resources::Stats.stub(:new).and_return(endpoint) }

    its(:stats) { should == endpoint }
  end
end
