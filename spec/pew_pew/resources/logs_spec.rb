# encoding: UTF-8

require 'spec_helper'

describe PewPew::Resources::Logs, :resource, :domain do
  let(:resource) { described_class.new(client) }

  context '#all' do
    let(:response) { resource.all }

    subject { response }

    specify { should be_success }

    its(:status) { should == 200 }
    its(:total_count) { should == 27 }

    context 'item' do
      subject { response.items.first }

      its(:created_at) { should == 'Fri, 01 Jun 2012 04:19:04 GMT' }
      its(:hap) { should == 'delivered' }
      its(:message) { should == "Delivered:  postmaster@pewpew.mailgun.org → pewpew@devoh.com 'Test'" }
      its(:message_id) { should == '4fc84273c474_48dd3fe70cc34cd05949d@rouge.local.mail' }
      its(:type) { should == 'info' }
    end
  end
end
