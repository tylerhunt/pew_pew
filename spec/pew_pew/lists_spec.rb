require 'support/api_request'
require 'support/vcr'

module PewPew
  RSpec.describe Lists, :api_request do
    subject(:lists) { described_class.new(api: api) }

    describe '#create', vcr: { cassette_name: 'lists/create' } do
      let(:address) { "test@#{ENV.fetch('MAILGUN_DOMAIN')}" }

      after do
        lists.remove(address: address).value!
      end

      it 'creates a mailing list with the given address' do
        lists.create(address: address).value!
      end
    end

    describe '#remove', vcr: { cassette_name: 'lists/remove' } do
      let(:address) { "test@#{ENV.fetch('MAILGUN_DOMAIN')}" }

      before do
        lists.create(address: address).value!
      end

      it 'removes mailing list with the given address' do
        lists.remove(address: address).value!
      end
    end

    describe '#create_member', vcr: { cassette_name: 'lists/create_member' } do
      let(:list_address) { "list@#{ENV.fetch('MAILGUN_DOMAIN')}" }
      let(:address) { "member@#{ENV.fetch('MAILGUN_DOMAIN')}" }

      before do
        lists.create(address: list_address).value!
      end

      after do
        lists.remove(address: list_address).value!
      end

      it 'adds a member to a mailing list' do
        lists.create_member(list_address, address: address).value!
      end
    end

    describe '#remove_member', vcr: { cassette_name: 'lists/remove_member' } do
      let(:list_address) { "list@#{ENV.fetch('MAILGUN_DOMAIN')}" }
      let(:address) { "member@#{ENV.fetch('MAILGUN_DOMAIN')}" }

      before do
        lists.create(address: list_address).value!
        lists.create_member(list_address, address: address).value!
      end

      after do
        lists.remove(address: list_address).value!
      end

      it 'removes a member from a mailing list' do
        lists.remove_member(list_address, address: address).value!
      end
    end

    describe '#update_member', vcr: { cassette_name: 'lists/update_member' } do
      let(:list_address) { "list@#{ENV.fetch('MAILGUN_DOMAIN')}" }
      let(:address) { "member@#{ENV.fetch('MAILGUN_DOMAIN')}" }

      before do
        lists.create(address: list_address).value!
        lists.create_member(list_address, address: address).value!
      end

      after do
        lists.remove(address: list_address).value!
      end

      it 'updates a member on a mailing list' do
        lists
          .update_member(list_address, address: address, subsscribed: false)
          .value!
      end
    end
  end
end
