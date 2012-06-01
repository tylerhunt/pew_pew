require 'spec_helper'

describe PewPew::Resources::Mailboxes, :resource, :domain do
  let(:resource) { described_class.new(client) }

  context '#all' do
    let(:response) { resource.all }

    subject { response }

    specify { should be_success }

    its(:status) { should == 200 }
    its(:total_count) { should == 1 }

    context 'item' do
      subject { response.items.first }

      its(:created_at) { should == 'Mon, 21 May 2012 22:12:54 GMT' }
      its(:mailbox) { should == 'postmaster@pewpew.mailgun.org' }
      its(:size_bytes) { should be_nil }
    end
  end

  context '#create' do
    let(:params) { { mailbox: 'test', password: 'secret' } }
    let(:response) { resource.create(params) }

    subject { response }

    specify { should be_success }

    its(:status) { should == 200 }
    its(:message) { should == 'Created 1 mailboxes' }
  end

  context '#update' do
    let(:params) { { password: 's3cr3t' } }
    let(:response) { resource.update('test', params) }

    subject { response }

    specify { should be_success }

    its(:status) { should == 200 }
    its(:message) { should == 'Password changed' }
  end

  context '#remove' do
    let(:response) { resource.remove('test') }

    subject { response }

    specify { should be_success }

    its(:status) { should == 200 }
    its(:message) { should == 'Mailbox has been deleted' }
  end
end
