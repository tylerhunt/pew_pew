require 'spec_helper'

describe PewPew::Resources::Campaigns, :resource, :domain do
  let(:resource) { described_class.new(client) }

  context '#all' do
    let(:response) { resource.all }

    subject { response }

    specify { should be_success }

    its(:status) { should == 200 }
    its(:total_count) { should == 1 }

    context 'item' do
      subject { response.items.first }

      its(:bounced_count) { should == 0 }
      its(:clicked_count) { should == 0 }
      its(:complained_count) { should == 0 }
      its(:created_at) { should == 'Sun, 03 Jun 2012 07:36:36 GMT' }
      its(:delivered_count) { should == 0 }
      its(:dropped_count) { should == 0 }
      its(:id) { should == '8ben' }
      its(:name) { should == 'Test' }
      its(:opened_count) { should == 0 }
      its(:submitted_count) { should == 0 }
      its(:unsubscribed_count) { should == 0 }
    end
  end

  context '#find' do
    let(:response) { resource.find('8ben') }

    subject { response }

    specify { should be_success }

    its(:status) { should == 200 }

    its(:bounced_count) { should == 0 }
    its(:clicked_count) { should == 0 }
    its(:complained_count) { should == 0 }
    its(:created_at) { should == 'Sun, 03 Jun 2012 07:36:36 GMT' }
    its(:delivered_count) { should == 0 }
    its(:dropped_count) { should == 0 }
    its(:id) { should == '8ben' }
    its(:name) { should == 'Test' }
    its(:opened_count) { should == 0 }
    its(:submitted_count) { should == 0 }
    its(:unsubscribed_count) { should == 0 }
  end

  context '#create' do
    let(:response) { resource.create(params) }

    context 'with an ID' do
      let(:params) { { name: 'Test', id: 'test' } }

      subject { response }

      specify { should be_success }

      its(:status) { should == 200 }
      its(:message) { should == 'Campaign created' }

      context 'campaign' do
        subject { response.campaign }

        its(:bounced_count) { should == 0 }
        its(:clicked_count) { should == 0 }
        its(:complained_count) { should == 0 }
        its(:created_at) { should == 'Sun, 03 Jun 2012 07:28:25 GMT' }
        its(:delivered_count) { should == 0 }
        its(:dropped_count) { should == 0 }
        its(:id) { should == 'test' }
        its(:name) { should == 'Test' }
        its(:opened_count) { should == 0 }
        its(:submitted_count) { should == 0 }
        its(:unsubscribed_count) { should == 0 }
      end
    end

    context 'without an ID' do
      let(:params) { { name: 'Test' } }

      subject { response }

      specify { should be_success }

      its(:status) { should == 200 }
      its(:message) { should == 'Campaign created' }

      context 'campaign' do
        subject { response.campaign }

        its(:bounced_count) { should == 0 }
        its(:clicked_count) { should == 0 }
        its(:complained_count) { should == 0 }
        its(:created_at) { should == 'Sun, 03 Jun 2012 07:36:36 GMT' }
        its(:delivered_count) { should == 0 }
        its(:dropped_count) { should == 0 }
        its(:id) { should == '8ben' }
        its(:name) { should == 'Test' }
        its(:opened_count) { should == 0 }
        its(:submitted_count) { should == 0 }
        its(:unsubscribed_count) { should == 0 }
      end
    end
  end

  context '#remove' do
    let(:response) { resource.remove('test') }

    subject { response }

    specify { should be_success }

    its(:status) { should == 200 }
    its(:message) { should == 'Campaign deleted' }

    its(:id) { should == 'test' }
  end

  context '#events' do
    let(:response) { resource.events('8ben') }

    subject { response }

    specify { should be_success }

    its(:status) { should == 200 }
    its(:total_count) { should == 0 }

    its(:items) { should == [] }
  end

  context '#stats' do
    let(:response) { resource.stats('8ben') }

    subject { response }

    specify { should be_success }

    its(:status) { should == 200 }

    context 'total' do
      subject { response.total }

      its(:bounced) { should == 0 }
      its(:clicked) { should == 0 }
      its(:complained) { should == 0 }
      its(:delivered) { should == 0 }
      its(:dropped) { should == 0 }
      its(:opened) { should == 0 }
      its(:sent) { should == 0 }
      its(:unsubscribed) { should == 0 }
    end

    context 'unique' do
      context 'clicked' do
        subject { response.unique.clicked }

        its(:link) { should == 0 }
        its(:recipient) { should == 0 }
      end

      context 'opened' do
        subject { response.unique.opened }

        its(:recipient) { should == 0 }
      end
    end
  end

  context '#clicks' do
    let(:response) { resource.clicks('8ben', group_by: 'domain') }

    subject { response }

    specify { should be_success }

    its(:status) { should == 200 }
    its(:total_count) { should == 0 }

    its(:items) { should == [] }
  end

  context '#opens' do
    let(:response) { resource.opens('8ben', group_by: 'domain') }

    subject { response }

    specify { should be_success }

    its(:status) { should == 200 }
    its(:total_count) { should == 0 }

    its(:items) { should == [] }
  end

  context '#unsubscribes' do
    let(:response) { resource.unsubscribes('8ben', group_by: 'domain') }

    subject { response }

    specify { should be_success }

    its(:status) { should == 200 }
    its(:total_count) { should == 0 }

    its(:items) { should == [] }
  end

  context '#complaints' do
    let(:response) { resource.complaints('8ben', group_by: 'domain') }

    subject { response }

    specify { should be_success }

    its(:status) { should == 200 }
    its(:total_count) { should == 0 }

    its(:items) { should == [] }
  end
end
