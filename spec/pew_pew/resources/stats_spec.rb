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
    let(:response) { resource.all }

    subject { response }

    specify { should be_success }

    context 'body' do
      subject { response.body }

      its(['total_count']) { should == 0 }
      its(['items']) { should == [] }
    end
  end
end
