module PewPew
  module Resources
    RSpec.describe Unsubscribes, :resource, :domain do
      let(:resource) { described_class.new(client) }

      context '#all' do
        let(:response) { resource.all }

        subject { response }

        specify { should be_success }

        its(:status) { should == 200 }
        its(:total_count) { should == 2 }

        context 'item' do
          subject { response.items.first }

          its(:address) { should == 'test@example.com' }
          its(:created_at) { should == 'Sat, 02 Jun 2012 02:54:37 GMT' }
          its(:id) { should == '4fc9806d8393c1618264c360' }
          its(:tag) { should == '*' }
        end
      end

      context '#find' do
        let(:response) { resource.find('test@example.com') }

        subject { response }

        specify { should be_success }

        its(:status) { should == 200 }
        its(:total_count) { should == 2 }

        context 'unsubscribe' do
          subject { response.items.first }

          its(:address) { should == 'test@example.com' }
          its(:created_at) { should == 'Sat, 02 Jun 2012 02:54:37 GMT' }
          its(:id) { should == '4fc9806d8393c1618264c360' }
          its(:tag) { should == '*' }
        end
      end

      context '#create' do
        let(:response) { resource.create(params) }

        subject { response }

        context 'with a tag' do
          let(:params) { { address: 'test@example.com', tag: 'newsletter' } }

          specify { should be_success }

          its(:status) { should == 200 }
          its(:message) {
            should == 'Address has been added to the unsubscribes table'
          }

          its(:address) { should == 'test@example.com' }
        end

        context 'without a tag' do
          let(:params) { { address: 'test@example.com' } }

          specify { should be_success }

          its(:status) { should == 200 }
          its(:message) {
            should == 'Address has been added to the unsubscribes table'
          }

          its(:address) { should == 'test@example.com' }
        end
      end

      context '#remove' do
        subject { response }

        context 'with an address' do
          let(:response) { resource.remove('test@example.com') }

          specify { should be_success }

          its(:status) { should == 200 }
          its(:message) { should == 'Unsubscribe event has been removed' }

          its(:address) { should == 'test@example.com' }
        end

        context 'with an unsubscribe event ID' do
          let(:response) { resource.remove('4fc9806d8393c1618264c360') }

          specify { should be_success }

          its(:status) { should == 200 }
          its(:message) { should == 'Unsubscribe event has been removed' }

          its(:address) { should == '4fc9806d8393c1618264c360' }
        end
      end
    end
  end
end
