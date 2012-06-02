require 'spec_helper'

describe PewPew::Resources::Complaints, :resource, :domain do
  let(:resource) { described_class.new(client) }

  context '#all' do
    let(:response) { resource.all }

    subject { response }

    specify { should be_success }

    its(:status) { should == 200 }
    its(:total_count) { should == 1 }

    context 'item' do
      subject { response.items.first }

      its(:address) { should == 'test@example.com' }
      its(:count) { should == 1 }
      its(:created_at) { should == 'Sat, 02 Jun 2012 06:55:56 GMT' }
    end
  end

  context '#find' do
    let(:response) { resource.find('test@example.com') }

    subject { response }

    specify { should be_success }

    its(:status) { should == 200 }

    context 'complaint' do
      subject { response.complaint }

      its(:address) { should == 'test@example.com' }
      its(:count) { should == 1 }
      its(:created_at) { should == 'Sat, 02 Jun 2012 06:55:56 GMT' }
    end
  end

  context '#create' do
    let(:params) { { address: 'test@example.com' } }
    let(:response) { resource.create(params) }

    subject { response }

    specify { should be_success }

    its(:status) { should == 200 }
    its(:message) { should == 'Address has been added to the complaints table' }

    its(:address) { should == 'test@example.com' }
  end

  context '#remove' do
    subject { response }

    let(:response) { resource.remove('test@example.com') }

    specify { should be_success }

    its(:status) { should == 200 }
    its(:message) { should == 'Spam complaint has been removed' }

    its(:address) { should == 'test@example.com' }
  end
end
