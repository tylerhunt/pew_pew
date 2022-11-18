module PewPew
  module Resources
    RSpec.describe Lists, :resource do
      let(:resource) { described_class.new(client) }

      context '#all' do
        let(:response) { resource.all }

        subject { response }

        specify { should be_success }

        its(:status) { should == 200 }
        its(:total_count) { should == 1 }

        context 'item' do
          subject { response.items.first }

          its(:address) { should == 'newsletter@pewpew.mailgun.org' }
          its(:created_at) { should == 'Mon, 04 Jun 2012 16:56:58 GMT' }
          its(:description) { should == 'Weekly News and Updates' }
          its(:members_count) { should == 0 }
          its(:name) { should == 'Newsletter' }
        end
      end

      context '#find' do
        let(:response) { resource.find('newsletter@pewpew.mailgun.org') }

        subject { response }

        specify { should be_success }

        its(:status) { should == 200 }

        context 'list' do
          subject { response.list }

          its(:address) { should == 'newsletter@pewpew.mailgun.org' }
          its(:created_at) { should == 'Mon, 04 Jun 2012 16:56:58 GMT' }
          its(:description) { should == 'Weekly News and Updates' }
          its(:members_count) { should == 0 }
          its(:name) { should == 'Newsletter' }
        end
      end

      context '#create' do
        let(:params) do
          {
            address: 'newsletter@pewpew.mailgun.org',
            description: 'Weekly News and Updates',
            name: 'Newsletter'
          }
        end

        let(:response) { resource.create(params) }

        subject { response }

        specify { should be_success }

        its(:status) { should == 200 }
        its(:message) { should == 'Mailing list has been created' }

        context 'list' do
          subject { response.list }

          its(:address) { should == 'newsletter@pewpew.mailgun.org' }
          its(:created_at) { should == 'Mon, 04 Jun 2012 16:56:58 GMT' }
          its(:description) { should == 'Weekly News and Updates' }
          its(:members_count) { should == 0 }
          its(:name) { should == 'Newsletter' }
        end
      end

      context '#update' do
        let(:params) { { description: 'Monthly News and Updates' } }
        let(:response) {
          resource.update('newsletter@pewpew.mailgun.org', params)
        }

        subject { response }

        specify { should be_success }

        its(:status) { should == 200 }
        its(:message) { should == 'Mailing list has been updated' }

        context 'list' do
          subject { response.list }

          its(:address) { should == 'newsletter@pewpew.mailgun.org' }
          its(:created_at) { should == 'Mon, 04 Jun 2012 16:56:58 GMT' }
          its(:description) { should == 'Monthly News and Updates' }
          its(:members_count) { should == 0 }
          its(:name) { should == 'Newsletter' }
        end
      end

      context '#remove' do
        let(:response) { resource.remove('newsletter@pewpew.mailgun.org') }

        subject { response }

        specify { should be_success }

        its(:status) { should == 200 }
        its(:message) { should == 'Mailing list has been deleted' }

        its(:address) { should == 'newsletter@pewpew.mailgun.org' }
      end

      context '#stats' do
        let(:response) { resource.stats('newsletter@pewpew.mailgun.org') }

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

      context '#all_members' do
        let(:response) do
          resource.all_members('newsletter@pewpew.mailgun.org')
        end

        subject { response }

        specify { should be_success }

        its(:status) { should == 200 }
        its(:total_count) { should == 1 }

        context 'member' do
          subject { response.items.first }

          its(:address) { should == 'member@example.com' }
          its(:name) { should == 'Member Name' }
          its(:subscribed) { should be_truthy }

          context 'vars' do
            subject { response.items.first.vars }

            its(:awesome) { should be_truthy }
          end
        end
      end

      context '#find_member' do
        let(:response) do
          resource.find_member(
            'newsletter@pewpew.mailgun.org',
            'member@example.com',
          )
        end

        subject { response }

        specify { should be_success }

        its(:status) { should == 200 }

        context 'member' do
          subject { response.member }

          its(:address) { should == 'member@example.com' }
          its(:name) { should == 'Member Name' }
          its(:subscribed) { should be_truthy }

          context 'vars' do
            subject { response.member.vars }

            its(:awesome) { should be_truthy }
          end
        end
      end

      context '#create_member' do
        let(:params) do
          {
            address: 'member@example.com',
            name: 'Member Name',
            vars: { awesome: true },
          }
        end

        let(:response) do
          resource.create_member('newsletter@pewpew.mailgun.org', params)
        end

        subject { response }

        specify { should be_success }

        its(:status) { should == 200 }
        its(:message) { should == 'Mailing list member has been created' }

        context 'member' do
          subject { response.member }

          its(:address) { should == 'member@example.com' }
          its(:name) { should == 'Member Name' }
          its(:subscribed) { should be_truthy }

          context 'vars' do
            subject { response.member.vars }

            its(:awesome) { should be_truthy }
          end
        end
      end

      context '#update_member' do
        let(:params) { { subscribed: false } }

        let(:response) do
          resource.update_member(
            'newsletter@pewpew.mailgun.org',
            'member@example.com',
            params,
          )
        end

        subject { response }

        specify { should be_success }

        its(:status) { should == 200 }
        its(:message) { should == 'Mailing list member has been updated' }

        context 'member' do
          subject { response.member }

          its(:address) { should == 'member@example.com' }
          its(:name) { should == 'Member Name' }
          its(:subscribed) { should be_falsey }

          context 'vars' do
            subject { response.member.vars }

            its(:awesome) { should be_truthy }
          end
        end
      end

      context '#remove_member' do
        let(:response) do
          resource.remove_member(
            'newsletter@pewpew.mailgun.org',
            'member@example.com',
          )
        end

        subject { response }

        specify { should be_success }

        its(:status) { should == 200 }
        its(:message) { should == 'Mailing list member has been deleted' }

        context 'member' do
          subject { response.member }

          its(:address) { should == 'member@example.com' }
        end
      end
    end
  end
end
