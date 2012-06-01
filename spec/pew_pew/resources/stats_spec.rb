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

    its(:status) { should == 200 }
    its(:total_count) { should == 10 }

    context 'item' do
      subject { response.items.first }

      its(:created_at) { should == 'Fri, 01 Jun 2012 00:00:00 GMT' }
      its(:event) { should == 'sent' }
      its(:id) { should == '4fc837558393c1618263d76c' }
      its(:tags) { should == {} }
      its(:total_count) { should == 11 }
    end
  end
end
