require 'spec_helper'

describe PewPew::Resources::Bounces, :resource, :domain do
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
      its(:code) { should == '554' }
      its(:error) { should == 'Relay access denied' }
      its(:created_at) { should == 'Sat, 02 Jun 2012 07:24:08 GMT' }
    end
  end

  context '#find' do
    let(:response) { resource.find('test@example.com') }

    subject { response }

    specify { should be_success }

    its(:status) { should == 200 }

    context 'bounce' do
      subject { response.bounce }

      its(:address) { should == 'test@example.com' }
      its(:code) { should == '554' }
      its(:error) { should == 'Relay access denied' }
      its(:created_at) { should == 'Sat, 02 Jun 2012 07:24:08 GMT' }
    end
  end

  context '#create' do
    let(:params) do
      {
        address: 'test@example.com',
        code: 554,
        error: 'Relay access denied',
      }
    end

    let(:response) { resource.create(params) }

    subject { response }

    specify { should be_success }

    its(:status) { should == 200 }
    its(:message) { should == 'Address has been added to the bounces table' }

    its(:address) { should == 'test@example.com' }
  end

  context '#remove' do
    subject { response }

    let(:response) { resource.remove('test@example.com') }

    specify { should be_success }

    its(:status) { should == 200 }
    its(:message) { should == 'Bounced address has been removed' }

    its(:address) { should == 'test@example.com' }
  end
end
