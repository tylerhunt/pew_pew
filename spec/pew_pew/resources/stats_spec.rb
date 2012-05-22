require 'spec_helper'

describe PewPew::Resources::Stats, :resource do
  let(:options) { {} }
  let(:resource) { described_class.new(client, options) }

  context 'options' do
    subject { resource }

    context 'without options' do
      its(:domain) { should == client.config.domain }
    end

    context 'with option :domain' do
      let(:options) { { domain: 'pewpew.test' } }

      its(:domain) { should == 'pewpew.test'}
    end
  end

  context '#all' do
    subject { resource.all }

    specify { should be_success }

    its(:body) { should match(/{\s+"total_count": 0,\s+"items": \[\]\s+}/) }
  end
end
