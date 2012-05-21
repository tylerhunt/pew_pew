require 'spec_helper'

describe PewPew::Config do
  {
    ENDPOINT: 'https://api.mailgun.net/v2',
    USER_AGENT: "PewPew Ruby Gem #{PewPew::VERSION}"
  }.each do |constant, value|
    context constant do
      subject { described_class.const_get(constant) }

      it { should == value }
    end
  end

  context 'defaults' do
    its(:api_key) { should be_nil }
    its(:domain) { should be_nil }
    its(:endpoint) { should == described_class::ENDPOINT }
    its(:user_agent) { should == described_class::USER_AGENT }
  end

  context '#api_key=' do
    specify do
      expect {
        subject.api_key = 'key-02n9f3ijl9sm9u97-8p7r-d7-15q-ui1'
      }.to change(subject, :api_key).to('key-02n9f3ijl9sm9u97-8p7r-d7-15q-ui1')
    end
  end

  context '#domain=' do
    specify do
      expect {
        subject.domain = 'pewpew.mailgun.org'
      }.to change(subject, :domain).to('pewpew.mailgun.org')
    end
  end

  context '#endpoint=' do
    specify do
      expect {
        subject.endpoint = 'https://api.mailgun.com/v2'
      }.to change(subject, :endpoint).to('https://api.mailgun.com/v2')
    end
  end

  context '#user_agent=' do
    specify do
      expect {
        subject.user_agent = 'A PewPew Application'
      }.to change(subject, :user_agent).to('A PewPew Application')
    end
  end
end
